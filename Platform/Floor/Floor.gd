extends StaticBody2D

onready var floorScene = load("res://Platform/Floor/Floor.tscn")

func _on_VisibilityNotifier2D_screen_exited():
	var child : StaticBody2D = floorScene.instance()
	child.position = global_position + Vector2(1024, 0)
	get_parent().call_deferred("add_child", child)

