extends Node2D

var board_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	board_scene = load("res://Board.tscn")
	add_child(board_scene.instance())