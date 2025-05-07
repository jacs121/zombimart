extends Node2D


func _input(event):
	if event.is_action_pressed("activate"):
		explotion(10, 1, get_global_mouse_position())
		print("self")

func explotion(radius: float, damage:int, _position: Vector2):
	var explotionArea = preload("res://assets/scenes/utils/explosion.tscn").instantiate()
	explotionArea.get_children()[0].shape.radius = radius
	explotionArea.global_position = _position
	self.add_child(explotionArea)
	explotionArea.damage = damage
