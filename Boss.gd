extends Area2D
enum State {
	idle,
	slam,
	laser
}

var current : State = State.idle;
var startingPos : Vector2;
const minimumSpeed : int = 50
const maxPosition : int = 500;
const time : float = .2;
const sceneSeconds : int = 10;
const DAMAGE_AMOUNT: int = 50
var secondsRemaining : int = sceneSeconds;
var numTime : float = 0;
var pastTargetX : int = 0;
var laserCharging: bool = false
var laserStartPos: Vector2
var laserEndPos: Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	startingPos = position;
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	numTime += delta;
	if (numTime < time):
		return;
	else:
		numTime -= time;
		secondsRemaining -= 1;
	
	if secondsRemaining <= 0:
		secondsRemaining = sceneSeconds;
		if current == State.idle:
			var random : int = randi_range(1, 2);
			current += random;
		else:
			current = State.idle;
	
	var tween = get_tree().create_tween();
	match current:
		State.idle:
			# Tries to generate a speed value that has a minimumBound (so the boss doesn't idle out)
			# and a maximum position deviation (so the boss doesn't go off the screen) 
			var speed : int = 0;
			var targetX: int = 0;
			var minX: int = startingPos.x - (maxPosition / 2);
			var maxX: int = startingPos.x + (maxPosition / 2);
			while (speed == 0 or targetX > maxX or targetX < minX or abs(pastTargetX - targetX) < minimumSpeed):
				speed = randi_range(-maxPosition + minimumSpeed, maxPosition - minimumSpeed);
				speed += (compareTo(speed, 0) * minimumSpeed);
				targetX = position.x + speed;
			# print(speed);
			pastTargetX = targetX;
			tween.tween_property($Sprite, "position", Vector2(targetX, position.y), time);
		State.slam:
			# Slam behavior code
			# Perform slam action, e.g., play a slam animation and deal damage to the player
			var player = get_tree().get_nodes_in_group("Player");
			tween.tween_property($Sprite, "position", Vector2(player[0].x, 0), time);
			tween.play();
			tween.tween_property($Sprite, "position", Vector2(player[0].x, startingPos.y), time);
			tween.play();
		State.laser:
			# Laser behavior code
			# Perform laser action, e.g., activate a laser attack or trigger a laser animation
			if numTime < time * 2:
				# Charging up
				var chargeTime: float = 3.0
				var chargeProgress: float = numTime / (time * 2)
				var chargeDirection: Vector2 = Vector2(-1, 0)  # Adjust the direction as needed
				var chargeDistance: float = chargeProgress * maxPosition / 2
				var chargeTarget: Vector2 = startingPos + chargeDirection * chargeDistance
				tween.tween_property($Sprite, "position", chargeTarget, time)
				if !laserCharging:
					laserCharging = true
					laserStartPos = position
				print("Charging up laser...");
				pass
			elif numTime < time * 3:
					# Shoot laser
					if laserCharging:
						laserCharging = false
						laserEndPos = position
						draw_laser()
						deal_damage_to_player();
					var laserDirection: Vector2 = Vector2(1, 0);  # Adjust the direction as needed
					var laserDistance: float = maxPosition / 2;
					var laserTarget: Vector2 = startingPos + laserDirection * laserDistance;
					tween.tween_property($Sprite, "position", laserTarget, time)
					
				# Perform laser action here, e.g., activate a laser attack or trigger a laser animation
			print("Firing laser!")
			tween.play()
			pass

func compareTo(first : int, second : int) -> int:
	if first > second:
		return 1;
	elif first < second:
		return -1;
	else:
		return 0;

func startNewPhase():
	var tween = get_tree().create_tween();
	tween.tween_property($Sprite, "position", startingPos, time);
	tween.play();
	
func draw_laser():
	var canvas_item = $CanvasItem
	canvas_item.draw_line(laserStartPos, laserEndPos, Color(1, 0, 0), 2)


func deal_damage_to_player():
	var body = get_tree().get_overlapping_nodes().get_nodes_in_group("Player");
	if (is_instance_valid(body[0])):
		body.take_damage(DAMAGE_AMOUNT);
		print("Player took", DAMAGE_AMOUNT, "damage from the laser!");
