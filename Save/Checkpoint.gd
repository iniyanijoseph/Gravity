extends Area2D

func _on_body_entered(body):
	if body.is_in_group("Player"):
		SaveAutoLoad.saveFile(body.checkPoint)
		body.checkPoint += 1
		print("saved")
