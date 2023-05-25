extends Node

func saveFile(newCheckpoint):
	var data = GameSaveData.new()
	data.checkpoint = newCheckpoint
	ResourceSaver.save(data, "res://Resources/SaveData.tres")

func loadFile():
	var newData = ResourceLoader.load("res://Resources/SaveData.tres")
	return newData
