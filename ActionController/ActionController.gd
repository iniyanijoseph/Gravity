extends CanvasLayer

@onready var actionTriggers : VBoxContainer = $ActionTriggers
@onready var pointsBar : ProgressBar = $HBoxContainer/ProgressBar
var pointsRemaining = 10

func _process(_delta):
	if PlayerActionSignalBus.playerState != PlayerActionSignalBus.playerStates.INERT:
		for button in actionTriggers.get_children():
			button.disabled = true
	else:
		for button in actionTriggers.get_children():
			if(pointsRemaining - button.cost >= 0):
				button.disabled = false
			else:
				button.disabled = true

func _on_RechargeTimer_timeout():
	pointsRemaining += 1
	pointsBar.value = pointsRemaining

func _on_SlamButton_pressed():
	pointsRemaining -= $ActionTriggers/SlamButton.cost
	pointsBar.value = pointsRemaining
	PlayerActionSignalBus.slamCall()


func _on_GravitateButton_pressed():
	pointsRemaining -= $ActionTriggers/GravitateButton.cost
	pointsBar.value = pointsRemaining
	PlayerActionSignalBus.gravitateCall()


func _on_RepelButton_pressed():
	pointsRemaining -= $ActionTriggers/RepelButton.cost
	pointsBar.value = pointsRemaining
	PlayerActionSignalBus.repelCall()
