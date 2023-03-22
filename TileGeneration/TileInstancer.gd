extends Node

var tileMap = {"basicMap" = preload("res://TileGeneration/TileConfigurationBasic.tscn")}


var index := 0
var order := [tileMap.get("basicMap"), tileMap.get("basicMap"), tileMap.get("basicMap"), tileMap.get("basicMap")]

func next(pos):
	if(index < order.size()):
		var instance = order[index].instantiate()
		instance.position = pos + Vector2(2294, 0)
		add_child(instance)
		index += 1
