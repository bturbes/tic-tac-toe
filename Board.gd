extends Node2D

var current_player = 'x'
var board_state
var total_moves = 0

var game_over_scene

signal player_move(x, y)

func _ready():
	board_state = [
		[null,null,null],
		[null,null,null],
		[null,null,null],
	]
	
	game_over_scene = load("res://GameOver.tscn")
	
	connect("player_move", self, "_player_move")
	
func _player_move(x, y):
	if board_state[y][x] == null:
		board_state[y][x] = current_player
		total_moves += 1
		
	print(board_state)
	check_winner()
	
	if current_player == 'x':
		current_player = 'o'
	elif current_player == 'o':
		current_player = 'x'
	else:
		print("well how did that happen")

func check_winner():
		
	# Check for winner in rows
	var row_wins
	for y in range(3):
		row_wins = true
		for x in range(3):
			if board_state[y][x] != current_player:
				row_wins = false
		if row_wins:
			win(current_player)
			return
	
	# Check for winner in columns
	var col_wins
	for x in range(3):
		col_wins = true
		for y in range(3):
			if board_state[y][x] != current_player:
				col_wins = false
		if col_wins:
			win(current_player)
			return
	
	# Check for winner in diagonals
	if board_state[0][0] == current_player && board_state[1][1] == current_player && board_state[2][2] == current_player:
		win(current_player)
		return
	
	if board_state[0][2] == current_player && board_state[1][1] == current_player && board_state[2][0] == current_player:
		win(current_player)
		return
		
	# Check if no winner
	if total_moves == 9:
		tie()
		return

func tie():
	game_over_dialog("Tie game!")

func win(player):
	game_over_dialog("Player '" + current_player + "' wins!")
		
func game_over_dialog(msg):
	print(msg)
	
	get_tree().paused = true
	
	var game_over = game_over_scene.instance()
	game_over.set_message(msg)
	game_over.z_index = 10	

	add_child(game_over)
