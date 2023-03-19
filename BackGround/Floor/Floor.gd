extends StaticBody2D


func _ready():
	print(position)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
