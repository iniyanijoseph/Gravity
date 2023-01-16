extends Control

func _on_SlamButton_pressed():
	PlayerActionSignalBus.slam()

func _on_GravitateButton_pressed():
	PlayerActionSignalBus.gravitate()

func _on_RepelButton_pressed():
	PlayerActionSignalBus.repel()
