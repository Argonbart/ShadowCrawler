extends ColorRect

@onready var cone_generator = $"../../../../../../ShapeGenerator/SubViewportContainer/SubViewport/ColorRect"

@export_range(0.0, 1.0) var cone_angle : float = 2.0
@export_range(0.0, 1000.0) var cone_length : float = 100.0

var first_time = true
var second_time = true

func _ready():
	pass#cone_generator.update_cone_shape(cone_length, cone_angle)

func _process(_delta):
	
	if first_time:
		material.set_shader_parameter("previous_texture", load("res://fogtextures/all_black.png"))
		first_time = false
		return
	
	if second_time:
		cone_generator.update_cone_shape(cone_length, cone_angle)
		second_time = false
	
	#cone_generator.update_cone_shape(cone_length, cone_angle)
	
	$"../FlashLightDrawing".material.set_shader_parameter("cone_angle", cone_angle)
	$"../FlashLightDrawing".material.set_shader_parameter("cone_length", cone_length)
	
	var current_image = ImageTexture.create_from_image($"..".get_viewport().get_texture().get_image())
	material.set_shader_parameter("previous_texture", current_image)
	#get_viewport().get_texture().get_image().save_png("res://current_fog_layer.png")
	$"../../../../FogDrawing".texture = current_image
