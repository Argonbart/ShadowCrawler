extends Node


@onready var player = $"../Player"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("space"):
		spawn_enemy()
	pass


func _on_ray_cast_2d_spawn_new_enemy():
	pass


func spawn_enemy():
	var new_enemy = load("res://scenes/enemy.tscn").instantiate()
	new_enemy.target = player
	add_child(new_enemy)
