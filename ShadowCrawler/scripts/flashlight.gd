extends PointLight2D

signal enemy_hit(body)
signal enemy_hit_stop(body)

@onready var player = $"../../.."
@onready var area = $LightArea

var enemy_in_cone
var last_body

func _process(_delta):
	if Input.is_action_just_pressed("click"):
		visible = not visible
	
	if enemy_in_cone:
		if visible:
			enemy_hit.emit(last_body)
		else:
			enemy_hit_stop.emit(last_body)

func _physics_process(_delta):
	look_at(get_global_mouse_position())
	global_position = player.position

func _ready():
	enemy_in_cone = false
	visible = false
	
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
	if body.name == "Enemy":
		enemy_in_cone = true
		last_body = body

func _on_light_area_body_exited(body):
	if body.name == "Enemy":
		enemy_in_cone = false
		last_body = body
