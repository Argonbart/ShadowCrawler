extends CharacterBody2D

@export var target: Node2D

var speed = 40
var acceleration = 7
var health

@onready var navigation_agent: NavigationAgent2D = $Navigation/NavigationAgent2D
@onready var _animated_sprite = $AnimatedSprite2D
@onready var healthbar = $Healthbar

var ray : RayCast2D

var ray_colliding_with_enemy
var is_in_light

func _ready():
	
	_animated_sprite.play("run")
	
	ray_colliding_with_enemy = false
	is_in_light = false
	
	health = 1000
	healthbar.init_health(health)
	
	#ray = get_tree().get_first_node_in_group("PlayerRay")
	ray = RayCast2D.new()
	add_child(ray)
	
func _physics_process(delta):
	
	# Ray stuff
	ray.target_position = target.global_position - global_position

	if ray.is_colliding():
		ray_colliding_with_enemy = ray.get_collider() == target
	
	if is_in_light and ray_colliding_with_enemy:
		healthbar.visible = true
		healthbar._set_health(healthbar.health - 0.2)
	else:
		healthbar.visible = false
	
	if healthbar.value <= 0:
		queue_free()
	
	var direction = Vector2.ZERO
	
	direction = navigation_agent.get_next_path_position() - global_position
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * speed, acceleration * delta)
	
	if direction.x < 0:
		_animated_sprite.flip_h = true
	else:
		_animated_sprite.flip_h = false
	
	move_and_slide()

var t = 0

func _on_timer_timeout():
	
	var proximity_range = 14
	var x_proximity = abs(global_position.x - target.global_position.x) < proximity_range
	var y_proximity = abs(global_position.y - target.global_position.y) < proximity_range
	if (x_proximity and y_proximity):
		print("Reached player!")
		get_tree().paused = true
	
	navigation_agent.target_position = target.global_position
	
	t += 1
	if (t == 20):
		_animated_sprite.play("attack")
		t = 0
	elif (t > 10):
		_animated_sprite.play("run")

func _on_collision_light_enemy_hit(body):
	if body.name == "Enemy":
		is_in_light = true

func _on_collision_light_enemy_hit_stop(body):
	if body.name == "Enemy":
		is_in_light = false
