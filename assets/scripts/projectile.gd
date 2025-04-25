extends Node2D


var direction = Vector2.ZERO
var speed = 0

func _process(delta):
	top_level = true
	global_position += direction * delta * speed

func setDirection(_direction, _speed):
	direction = _direction*10
	speed = _speed
