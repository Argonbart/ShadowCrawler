extends Node2D

@onready var game_over_screen = $"../InterfaceCanvas/Interface/Control/GameOver"
@onready var winning_screen = $"../InterfaceCanvas/Interface/Control/WinBlock"
@onready var countdown_screen = $"../InterfaceCanvas/Interface/Control/Countdown"
@onready var continue_counter = $ContinueCountdown

var won = false
var countdown = 3

func _ready():
	return # remove to add counter again (+make control node visible again)
	#game_over_screen.visible = false
	#winning_screen.visible = false
	#countdown_screen.visible = false
	#get_tree().paused = true
	#start_counter()

func _process(_delta):
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	if won and Input.is_action_just_pressed("continue"):
		won = false
		winning_screen.visible = false
		start_counter()

func game_lost():
	get_tree().paused = true
	game_over_screen.visible = true

func game_won():
	won = true
	get_tree().paused = true
	winning_screen.visible = true

func start_counter():
	countdown_screen.visible = true
	countdown_screen.get_child(0).text = str(countdown)
	countdown = countdown - 1
	continue_counter.start()

func _on_continue_countdown_timeout():
	if countdown == 0:
		countdown_screen.visible = false
		get_tree().paused = false
		countdown = 3
	else:
		countdown_screen.get_child(0).text = str(countdown)
		countdown = countdown - 1
		continue_counter.start()
