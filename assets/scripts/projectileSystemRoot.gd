extends Node2D

class_name Projectile

var direction = Vector2.ZERO
@export var speed: float = 0
@export var killActionTime: float
@export var texture: Texture2D
@export var damage: int

@export var usable: bool = true

var killAction : Callable
var hitAction : Callable
var onUseAction : Callable

func _ready() -> void:
	var timer = get_tree().create_timer(killActionTime)
	timer.connect("timeout", kill)
	if onUseAction:
		onUseAction.call()

func kill() -> void:
	if killAction:
		killAction.call()
	queue_free()

func _process(delta):
	top_level = true
	global_position += direction * delta * speed
	if texture:
		$Sprite.texture = texture

func setDirection(_direction, _speed):
	direction = _direction*10
	global_position += direction
	speed = _speed

func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.is_in_group("enemy"):
		if area.get_parent().has_method("damageSelf"):
			area.get_parent().damageSelf(damage, 0)
			print("Hit A Baddie For " + str(damage) + " dmg")
			queue_free()
