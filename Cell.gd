extends Node2D

export (int) var x_loc = 0
export (int) var y_loc = 0

var state = null
var hover = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.connect("mouse_entered", self, "_mouse_entered")
	$Area2D.connect("mouse_exited", self, "_mouse_exited")
	$Area2D.connect("input_event", self, "_input")
	
func _input(event):
	var board = get_parent()
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		if hover and state == null:
			if board.current_player == 'x':
				state = 'x'
				$X/Sprite.modulate = Color(1,1,1,1)
			elif board.current_player == 'o':
				state = 'o'
				$O/Sprite.modulate = Color(1,1,1,1)

			board.emit_signal("player_move", x_loc, y_loc)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var board = get_parent()
	if state == null:
		if hover:
			if board.current_player == 'x':
				$X.visible = true
			elif board.current_player == 'o':
				$O.visible = true
			else:
				print("wtf!!")
		else:
			$X.visible = false
			$O.visible = false
	
func _mouse_entered():
	hover = true

func _mouse_exited():
	hover = false
