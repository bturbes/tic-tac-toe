extends Node2D

var board_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	board_scene = load("res://Board.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_message(msg):
	$Control/RichTextLabel.text = msg

func _on_play_again_pressed():
	# Delete original board
	var root = get_tree().get_root().get_node("/root/Root")
	var old_board = get_parent()
	old_board.queue_free()
		
	var new_board = board_scene.instance()
	root.add_child(new_board)
	
	get_tree().get_root().print_tree()
	queue_free()
