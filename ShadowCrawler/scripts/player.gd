extends CharacterBody2D

@onready var _animated_sprite = $PlayerSprite
@onready var flashlight_area = $PlayerLight/ConeLight/Flashlight/ConeArea

var flashlight_active = false

func _process(_delta):
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
