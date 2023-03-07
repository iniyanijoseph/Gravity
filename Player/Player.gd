extends KinematicBody2D

signal action_complete
onready var floorFindRayCast : RayCast2D = $"%FloorFindRayCast"
onready var camera : Camera2D = $"%Camera2D"

export(int) var speed : int = 500
onready var cameraDefaultOffset = camera.offset.x

#var data: Character setget get_data 
func _ready():
	# Set Up Signal Bus
	var _a = connect("action_complete", PlayerActionSignalBus, "complete_action")
	PlayerActionSignalBus.player = self
	PlayerActionSignalBus.setup()

func freezeCamera():
	remove_child(camera)
	get_parent().add_child(camera)
	camera.position = position

func unfreezeCamera():
	camera.offset.x =  camera.position.x - position.x
	camera.position.x = 0
	get_parent().remove_child(camera)
	add_child(camera)

func slam():
	var localFloor = floorFindRayCast.get_collision_point()
	freezeCamera()
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position:y", localFloor.y - floorFindRayCast.position.y, 1).\
	set_trans(Tween.TRANS_QUINT).\
	set_ease(Tween.EASE_IN)
	yield(tween, "finished")
	action_complete()
	unfreezeCamera()

func gravitate():
	#Replace With Code to Gravitate to a Point
	action_complete()

func repel():
	#Replace With Code to Repel Enemies for a short period of Time
	action_complete()

# Call Whenever an action is complete to update player state
func action_complete():
	emit_signal("action_complete")

func _physics_process(delta):
	if(cameraDefaultOffset-3 <= camera.offset.x and camera.offset.x <= cameraDefaultOffset + 3):
		move_and_slide(Vector2(speed, 0))
	else:
		camera.offset.x += speed*delta
