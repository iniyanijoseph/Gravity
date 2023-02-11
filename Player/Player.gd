extends KinematicBody2D

signal action_complete
onready var floorFindRayCast : RayCast2D = $"%FloorFindRayCast"

func _ready():
	# Set Up Signal Bus
	var _a = connect("action_complete", PlayerActionSignalBus, "complete_action")
	PlayerActionSignalBus.player = self
	PlayerActionSignalBus.setup()

func slam():
	var localFloor = floorFindRayCast.get_collision_point()
	print(localFloor)
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position:y", localFloor.y - floorFindRayCast.position.y, 1).\
	set_trans(Tween.TRANS_QUINT).\
	set_ease(Tween.EASE_IN)
	yield(tween, "finished")
	action_complete()

var gravitateDestination = Vector2()

func _input(event):
	if event.is_action_released("ui_left_click"):
		gravitateDestination = get_local_mouse_position()
		print(gravitateDestination)
		emit_signal("start_gravitation")

signal start_gravitation

func gravitate():
	yield(self, "start_gravitation")
	var speed = 1 # seconds
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", gravitateDestination, speed)
	
	yield(tween, "finished")
	
	action_complete()


func repel(enemies):
	var player = self
	var speed = 0.5 # seconds

	# Create a Tween that moves each enemy away from the player
	for enemy in enemies:
		var direction = (enemy.position - player.position).normalized()
		var destination = enemy.position + (direction * 100) # 100 is the distance from the player

		var repel_tween = get_tree().create_tween()
		repel_tween.tween_property(enemy, "position", enemy.position, destination, speed, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
		repel_tween.start()

		yield(repel_tween, "tween_completed")

	action_complete()


# Call Whenever an action is complete to update player state
func action_complete():
	emit_signal("action_complete")

func _physics_process(delta):
	move_and_slide(Vector2(200, 0))
