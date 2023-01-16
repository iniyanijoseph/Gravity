extends Node

var player : KinematicBody2D

signal slam
signal gravitate
signal repel

var playerState = playerStates.INERT
enum playerStates{SLAM, GRAVITATE, REPEL, INERT}

func setup():
	var _a = connect("slam", player, "slam")
	var _b = connect("gravitate", player, "gravitate")
	var _c = connect("repel", player, "repel")

func slam():
	playerState = playerStates.SLAM
	emit_signal("slam")

func gravitate():
	playerState = playerStates.GRAVITATE
	emit_signal("gravitate")

func repel():
	playerState = playerStates.REPEL
	emit_signal("repel")

func complete_action():
	playerState = playerStates.INERT
