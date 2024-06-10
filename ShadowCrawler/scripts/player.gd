extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D

#func _input(event):
#	if event is InputEventKey:
#		var keycode = DisplayServer.keyboard_get_keycode_from_physical(event.physical_keycode)
#		print(OS.get_keycode_string(keycode))

func _process(_delta):
	if Input.is_action_pressed("right") or Input.is_action_pressed("left"):
		_animated_sprite.play("run")
	else:
		_animated_sprite.play("default")

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
