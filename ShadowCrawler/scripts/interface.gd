extends Control

signal player_dead()
signal player_won()

@onready var hearts_node = $Hearts
@onready var hearts = hearts_node.get_children()
@onready var hearts_left = len(hearts)
@onready var kills_node = $Kills
@onready var kills_label = kills_node.get_child(1)
@onready var ghoul_counter = 0

func _ready():
	kills_label.text = str(ghoul_counter)

func minus_heart():
	hearts[hearts_left-1].texture = preload("res://extra/empty_heart.png")
	hearts_left = hearts_left - 1
	if hearts_left == 0:
		player_dead.emit()

func ghoul_kill():
	ghoul_counter = ghoul_counter + 1
	kills_label.text = str(ghoul_counter)
	if ghoul_counter == 10:
		player_won.emit()
