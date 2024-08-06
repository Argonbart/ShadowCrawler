extends CharacterBody2D

@onready var _animated_sprite = $PlayerSprite
@onready var flashlight_area = $PlayerLight/ConeLight/Flashlight/ConeArea
@onready var enemy_spawn_protection = $SpawnProtection
@onready var interface = $"../InterfaceCanvas/Interface"
@onready var damaged_protection = $DamageProtection
@onready var canvas_modulate = $"../Darkness"

var health = 3
var damaged = false
var flashlight_active = false

func _process(_delta):
	if !damaged:
		if Input.is_action_pressed("right") or Input.is_action_pressed("left") or Input.is_action_pressed("up") or Input.is_action_pressed("down"):
			_animated_sprite.play("run")
		else:
			_animated_sprite.play("default")
	
	if Input.is_action_just_pressed("click"):
		flashlight_active = not flashlight_active

@export var speed = 100

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(_delta):
	get_input()
	var horizontal_direction = Input.get_axis("left", "right")
	
	if horizontal_direction != 0:
		_animated_sprite.flip_h = (horizontal_direction == -1)
	
	move_and_slide()

func damage_player(damage_taken):
	if !damaged:
		health = health - damage_taken
		for i in range(damage_taken):
			interface.minus_heart()
		damaged = true
		damaged_protection.start()
		_animated_sprite.play("hurt")
		damaged_protection.get_child(0).start()
		canvas_modulate.color = Color("#641414")

func _on_interface_player_dead():
	get_parent().get_child(0).game_lost()

func _on_damage_protection_timeout():
	damaged = false
	_animated_sprite.play("default")

func killed_ghoul():
	interface.ghoul_kill()

func _on_interface_player_won():
	get_parent().get_child(0).game_won()

func _on_red_glow_up_timeout():
	canvas_modulate.color = Color("#323232")
