extends PointLight2D

@onready var player = get_parent()
@onready var area = $LightArea

func _process(_delta):
	if Input.is_action_just_pressed("click"):
		enabled = not enabled

func _physics_process(_delta):
	look_at(get_global_mouse_position())
	global_position.x = player.position.x

func _ready():
	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(texture.get_image())
	
	var polys = bitmap.opaque_to_polygons(Rect2(Vector2.ZERO, texture.get_size()))
	for poly in polys:
		var collision_polygon = CollisionPolygon2D.new()
		collision_polygon.polygon = poly
		area.add_child(collision_polygon)
		collision_polygon.position -= Vector2(bitmap.get_size() / 2)
	
	area.position = player.position

func _on_light_area_body_entered(body):
	modulate = Color.RED

func _on_light_area_body_exited(body):
	modulate = Color.WHITE
