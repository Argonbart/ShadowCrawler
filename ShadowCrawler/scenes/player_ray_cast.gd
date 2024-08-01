extends RayCast2D

signal spawn_new_enemy()

var enemy

func _ready():
	enemy = get_tree().get_first_node_in_group("Enemy")
	
func _process(_delta):
	if is_instance_valid(enemy):
		target_position = enemy.position - get_parent().position
	else:
		spawn_new_enemy.emit()
