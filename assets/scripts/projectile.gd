extends Node2D

class_name Projectile

var direction = Vector2.ZERO
@export var speed : float = 0

@export var actionTime : float

var action : Callable

func _ready() -> void:
	var timer = get_tree().create_timer(actionTime)
	timer.connect("timeout", action)
	kill()

func kill() -> void:
	queue_free()

func _process(delta):
	top_level = true
	global_position += direction * delta * speed

func setDirection(_direction, _speed):
	direction = _direction*10
	speed = _speed
