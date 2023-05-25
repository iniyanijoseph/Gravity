extends CanvasLayer

@onready var animationPlayer : AnimationPlayer = $AnimationPlayer

func _on_button_pressed():
	get_tree().paused = true
	$AnimationPlayer.play("showMenu")

func _on_unpause_button_pressed():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("showMenu")

func _on_exit_button_pressed():
	get_tree().quit()

func _on_audio_slider_value_changed(value):
	var sfx_index= AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(sfx_index, 6*value)
