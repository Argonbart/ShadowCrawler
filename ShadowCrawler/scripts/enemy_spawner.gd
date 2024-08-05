extends Node

@onready var player = $"../Player"

func _process(_delta):
	if Input.is_action_just_pressed("space"):
		spawn_enemy()

func spawn_enemy():
	var new_enemy = load("res://scenes/enemy.tscn").instantiate()
	new_enemy.player = player
	add_child(new_enemy)
