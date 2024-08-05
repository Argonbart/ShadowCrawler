extends Node

@onready var player = $"../Player"

var spawning_points = [Vector2(-140, -70), Vector2(-140, 70), Vector2(240, -70), Vector2(240, 70)]

func _process(_delta):
	if Input.is_action_just_pressed("space"):
		spawn_enemy()

func spawn_enemy():
	var new_enemy = load("res://scenes/enemy.tscn").instantiate()
	new_enemy.player = player
	new_enemy.global_position = spawning_points[randi_range(0,3)]
	add_child(new_enemy)

func _on_timer_timeout():
	spawn_enemy()
