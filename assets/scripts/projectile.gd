extends Node2D

class_name Projectile

var direction = Vector2.ZERO
@export var speed: float = 0
@export var killActionTime: float
@export var texture: Texture2D
@export var damage: int

var killAction : Callable
var hitAction : Callable

func _ready() -> void:
	var timer = get_tree().create_timer(killActionTime)
	timer.connect("timeout", kill)

func kill() -> void:
	if killAction:
		killAction.call()
	queue_free()

func _process(delta):
	top_level = true
	global_position += direction * delta * speed
	if texture:
		$Sprite.texture = texture


func _on_hit_body_entered(body: Node2D):
	print(body)
	if body is TileMap:
		pass
	elif body.name == "Player":
		pass
	else:
		body.damageSelf(damage, 0)
		kill()


func setDirection(_direction, _speed):
	direction = _direction*10
	global_position += direction
	speed = _speed
