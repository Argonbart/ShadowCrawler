extends Node2D

@export var player: CharacterBody2D
@export var ghoul: CharacterBody2D
@export var healthbar: ProgressBar

func _process(_delta):
	if Input.is_action_pressed("reset"):
			player.global_position.x = 0
			player.global_position.y = 0
			ghoul.global_position.x = 160
			ghoul.global_position.y = 20
			healthbar._set_health(healthbar.max_value)
			get_tree().paused = false
			
