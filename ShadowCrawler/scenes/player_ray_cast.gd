extends RayCast2D

var enemy

func _ready():
	enemy = get_tree().get_first_node_in_group("Enemy")
	
func _process(_delta):
	target_position = enemy.position - get_parent().position
