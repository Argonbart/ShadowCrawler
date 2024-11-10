extends ColorRect

@onready var light_origin = get_viewport_rect().size / 2.0

func _ready():
	material.set_shader_parameter("light_origin", light_origin)

func _process(_delta):
	material.set_shader_parameter("mouse_position", get_viewport().get_mouse_position())
