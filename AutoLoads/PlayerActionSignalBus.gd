extends Node

var player : KinematicBody2D

signal slam
signal gravitate
signal repel

var playerState = playerStates.INERT
enum playerStates{SLAM, GRAVITATE, REPEL, INERT}

func _ready():
	connect("slam", player, "slam")
	connect("gravitate", player, "gravitate")

func complete_action():
	playerState = playerStates.INERT
