extends PointLight2D

@onready var player = get_parent()

func _process(_delta):
	if Input.is_action_just_pressed("click"):
		enabled = not enabled

func _physics_process(_delta):
	look_at(get_global_mouse_position())
	global_position.x = player.position.x
