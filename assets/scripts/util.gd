extends Node2D

class_name Utils

func explosion(radius: float, damage: int, _position: Vector2):
	var explosion_area = preload("res://assets/scenes/utils/explosion.tscn").instantiate()
	explosion_area.get_children()[0].shape.radius = radius
	explosion_area.global_position = _position
	explosion_area.damage = damage
	call_deferred("add_child", explosion_area)
