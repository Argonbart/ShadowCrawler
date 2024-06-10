extends Node2D

@export var player: Node2D
@export var ghoul: Node2D

func _process(_delta):
	if Input.is_action_pressed("reset"):
			player.global_position.x = 0
			player.global_position.y = 0
			ghoul.global_position.x = 160
			ghoul.global_position.y = 20
			get_tree().paused = false
