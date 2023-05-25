extends TileMap

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()

func _on_visible_on_screen_enabler_2d_screen_entered():
	if(get_parent().is_in_group("TileOrder")):
		get_parent().next(position)
