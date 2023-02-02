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
	move_and_slide(Vector2(200, 0))
