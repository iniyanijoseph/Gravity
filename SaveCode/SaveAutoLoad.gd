extends Node


func saveFile(newCheckpoint):
	var data = GameSaveData.new()
	data.checkpoint = newCheckpoint
	ResourceSaver.save("res://Resources/SaveData.tres", data)
	
func loadFile():
	var newData = ResourceLoader.load("res://Resources/SaveData.tres")
	return newData
