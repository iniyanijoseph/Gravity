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
var numTime : float = 0;
const time : float = .2;
var pastTargetX : int = 0;


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
			pass
			
		State.laser:
			# Laser behavior code
			# Perform laser action, e.g., activate a laser attack or trigger a laser animation
			pass
	tween.play();

func compareTo(first : int, second : int) -> int:
	if first > second:
		return 1;
	elif first < second:
		return -1;
	else:
		return 0;
