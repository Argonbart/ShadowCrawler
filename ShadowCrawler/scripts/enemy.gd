extends CharacterBody2D

@onready var navigation_agent: NavigationAgent2D = $Navigation/NavigationAgent2D
@onready var _animated_sprite = $GhoulSprite
@onready var healthbar = $Healthbar

# Ghoul Attributes
var speed = 40
var acceleration = 7
var health = 1000
var direction
var animation_ticker = 0

# Player Ray
@export var player: CharacterBody2D
var player_ray : RayCast2D
var player_ray_colliding

# Ghoul Conditions
var is_in_light

func _ready():

	_animated_sprite.play("run")
	
	if player.flashlight_area.overlaps_body(self):
		is_in_light = true
	else:
		is_in_light = false
	player_ray_colliding = false
	healthbar.visible = false
	direction = Vector2.ZERO
	healthbar.init_health(health)
	player_ray = RayCast2D.new()
	add_child(player_ray)

func _physics_process(delta):

	player_ray.target_position = player.global_position - global_position
	
	var hit = false
	while player_ray.is_colliding() and !hit:
		var obj = player_ray.get_collider()
		if obj != null:
			if obj.is_in_group("Enemy"):
				player_ray.add_exception(obj)
				player_ray.force_raycast_update()
			elif obj.is_in_group("Player"):
				player_ray_colliding = true
				hit = true
			else:
				player_ray_colliding = false
				hit = true
	
	if player.flashlight_active and is_in_light and player_ray_colliding:
		healthbar.visible = true
		healthbar.health = healthbar.health - 0.2
	else:
		healthbar.visible = false
	
	if healthbar.value <= 0:
		queue_free()
		player.killed_ghoul()
	
	# Navigation
	direction = navigation_agent.get_next_path_position() - global_position
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * speed, acceleration * delta)
	
	if direction.x < 0:
		_animated_sprite.flip_h = true
	else:
		_animated_sprite.flip_h = false
	
	move_and_slide()

func _on_timer_timeout():
	
	var proximity_range = 14
	var x_proximity = abs(global_position.x - player.global_position.x) < proximity_range
	var y_proximity = abs(global_position.y - player.global_position.y) < proximity_range
	if (x_proximity and y_proximity):
		player.damage_player(1)
	
	navigation_agent.target_position = player.global_position
	
	animation_ticker += 1
	if (animation_ticker == 20):
		_animated_sprite.play("attack")
		animation_ticker = 0
	elif (animation_ticker > 10):
		_animated_sprite.play("run")

func entered_light():
	is_in_light = true

func exited_light():
	is_in_light = false
