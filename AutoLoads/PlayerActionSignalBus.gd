extends Node

var player
signal slam
signal gravitate

func _ready():
	connect("slam", player, "slam")
	connect("gravitate", player, "gravitate")
