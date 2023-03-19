extends Node

var player : CharacterBody2D

signal slam
signal gravitate
signal repel

var playerState = playerStates.INERT
enum playerStates{SLAM, GRAVITATE, REPEL, INERT}

func setup():
	var _a = connect("slam",Callable(player,"slam"))
	var _b = connect("gravitate",Callable(player,"gravitate"))
	var _c = connect("repel",Callable(player,"repel"))

func slamCall():
	playerState = playerStates.SLAM
	emit_signal("slam")

func gravitateCall():
	playerState = playerStates.GRAVITATE
	emit_signal("gravitate")

func repelCall():
	playerState = playerStates.REPEL
	emit_signal("repel")

func complete_action():
	playerState = playerStates.INERT
