extends ColorRect

func update_cone_shape(cone_length, cone_width_rad):

	var flashlight1 = $"../../../../Player/PlayerLight/ConeLight/Flashlight"
	var flashlight2 = $"../../../../Player/PlayerLight/ConeLight/Flashlight/ConeShadowLight"

	$"../..".size = Vector2(2.0 * cone_length, 2.0 * cone_length)
	$"..".size = Vector2(2.0 * cone_length, 2.0 * cone_length)
	$".".size = Vector2(2.0 * cone_length, 2.0 * cone_length)
	$".".material.set_shader_parameter("u_cone_length", cone_length)
	$".".material.set_shader_parameter("u_cone_width", cone_width_rad)

	#$"..".get_texture().get_image().save_png("res://cone_texture.png")

	await RenderingServer.frame_post_draw
	flashlight1.texture = $"..".get_texture()
	flashlight2.texture = $"..".get_texture()
