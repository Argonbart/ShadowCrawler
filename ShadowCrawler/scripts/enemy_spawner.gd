extends Node

@onready var player = $"../Player"
@onready var spawning_points_collection = $SpawnPoints
@onready var spawning_points = spawning_points_collection.get_children()

func _process(_delta):
	if Input.is_action_just_pressed("space"):
		spawn_enemy()

func spawn_enemy():
	var new_enemy = load("res://scenes/enemy.tscn").instantiate()
	new_enemy.player = player
	var spawn_possible = false
	for point in spawning_points:
		if !point.overlaps_area(player.enemy_spawn_protection):
			spawn_possible = true
			continue
	if spawn_possible:
		var next_spawn_point = spawning_points[randi_range(0,len(spawning_points)-1)]
		while next_spawn_point.overlaps_area(player.enemy_spawn_protection):
			next_spawn_point = spawning_points[randi_range(0,len(spawning_points)-1)]
		new_enemy.global_position = next_spawn_point.get_child(0).global_position
		add_child(new_enemy)

func _on_timer_timeout():
	spawn_enemy()
