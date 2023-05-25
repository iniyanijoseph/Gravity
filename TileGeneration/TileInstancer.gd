extends Node

var tileMap = {"Map1" = preload("res://TileGeneration/TileConfiguration1.tscn"), "Map2" = preload("res://TileGeneration/TileConfiguration2.tscn"), "Map3" = preload("res://TileGeneration/TileConfiguration3.tscn"), "Map4" = preload("res://TileGeneration/TileConfiguration4.tscn")}


var index := 0
var order := [tileMap.get("Map1"), tileMap.get("Map1"), tileMap.get("Map2"), tileMap.get("Map3"), tileMap.get("Map4"), tileMap.get("Map3")]

func next(pos):
	if(index < order.size()):
		var instance = order[index].instantiate()
		instance.position = pos + Vector2(2294, 0)
		add_child(instance)
		index += 1
