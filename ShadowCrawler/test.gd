extends Sprite2D

@onready var area = $Area2D

func _ready():
	area.connect('mouse_entered', self, '_on_mouse_entered')
	area.connect('mouse_exited', self, '_on_mouse_exited')
