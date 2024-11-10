@tool
class_name MyTool
extends Node2D

@export var resource: Node2D:
	set(new_resource):
		resource = new_resource
		_on_resource_set()

# This will only be called when you create, delete, or paste a resource.
# You will not get an update when tweaking properties of it.
func _on_resource_set():
	print("My resource was set!")
