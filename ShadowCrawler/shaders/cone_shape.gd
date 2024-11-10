extends ColorRect

@onready var flashlight1 = $"../../../../Player/PlayerLight/ConeLight/Flashlight"
@onready var flashlight2 = $"../../../../Player/PlayerLight/ConeLight/Flashlight/ConeShadowLight"

func update_cone_shape(cone_length, cone_width_rad):

	$"../..".size = Vector2(2.0 * cone_length, 2.0 * cone_length)
	$"..".size = Vector2(2.0 * cone_length, 2.0 * cone_length)
	$".".size = Vector2(2.0 * cone_length, 2.0 * cone_length)
	$".".material.set_shader_parameter("u_cone_length", cone_length)
	$".".material.set_shader_parameter("u_cone_width", cone_width_rad)

	#$"..".get_texture().get_image().save_png("res://cone_texture.png")

	var image_texture = ImageTexture.create_from_image($"..".get_texture().get_image())

	if flashlight1 and image_texture != null:
		flashlight1.texture = image_texture
	
	if flashlight2 and image_texture != null:
		flashlight2.texture = image_texture
