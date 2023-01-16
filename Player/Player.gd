extends KinematicBody2D

signal action_complete

func _ready():
	# Set Up Signal Bus
	var _a = connect("action_complete", PlayerActionSignalBus, "complete_action")
	PlayerActionSignalBus.player = self
	PlayerActionSignalBus.setup()

func slam():
	#Replace With Code to Slam
	pass

func gravitate():
	#Replace With Code to Gravitate to a Point
	pass

func repel():
	#Replace With Code to Repel Enemies for a short period of Time
	pass

# Call Whenever an action is complete to update player state
func action_complete():
	emit_signal("action_complete")
