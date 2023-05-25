extends CharacterBody2D

signal action_complete
@onready var floorFindRayCast : RayCast2D = $"%FloorFindRayCast"
@onready var camera : Camera2D = $"%Camera2D"

@export var speed: int = 500
@onready var cameraDefaultOffset = camera.offset.x

var checkPoint : int = 0

func _ready():
	# Set Up Signal Bus
	var _a = connect("action_complete",Callable(PlayerActionSignalBus,"complete_action"))
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
	await tween.finished
	action_complete_call()
	unfreezeCamera()

func gravitate():
	#Replace With Code to Gravitate to a Point
	action_complete_call()

func repel():
	#Replace With Code to Repel Enemies for a short period of Time
	action_complete_call()

# Call Whenever an action is complete to update player state
func action_complete_call():
	emit_signal("action_complete")

func _physics_process(delta):
	if(cameraDefaultOffset-3 <= camera.offset.x and camera.offset.x <= cameraDefaultOffset + 3):
		set_velocity(Vector2(speed, 0))
		move_and_slide()
	else:
		camera.offset.x += speed*delta

func hurt():
	print("OW")


