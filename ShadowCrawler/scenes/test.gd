extends Sprite2D

@onready var area = $Area2D

func _ready():
	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(texture.get_image())
	
	var polys = bitmap.opaque_to_polygons(Rect2(Vector2.ZERO, texture.get_size()))
	for poly in polys:
		var collision_polygon = CollisionPolygon2D.new()
		collision_polygon.polygon = poly
		area.add_child(collision_polygon)
		
		if centered:
			collision_polygon.position -= Vector2(bitmap.get_size() / 2)

func _on_area_2d_mouse_entered():
	modulate = Color.RED

func _on_area_2d_mouse_exited():
	modulate = Color.WHITE
