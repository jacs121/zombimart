extends Node2D

@export_group("weapon")
@export var weaponName: String
@export var weaponTexture: Texture2D
@export var meleeCooldown: float = 0
@export var rangeCooldown: float = 0
@export var explosiveCooldown: float = 0
@onready var player = $"."
@onready var raycast:RayCast2D = $"../raycast"

@export_group("melee")
@export var melee: bool = false
@export var meleeDamage: int = 0
@export var meleeRange: int = 36
@export var meleeKnockback: int = 0

@export_group("range")
@export var range: bool = false
@export var bulletTexture: Texture2D
@export var rangeDamage: int
@export var rangeSpeed: float

@export_group("explosive")
@export var explosive: bool = false
@export var explosiveTexture: Texture2D
enum _explosiveTypes {place, throw, lounch}
@export var explosiveType: _explosiveTypes = _explosiveTypes.place
@export var explodeTimer: float = -1
@export var explodeOnCollision: bool = false

func _ready():
	pass

func _process(delta):
	if melee:
		if Input.is_action_just_pressed("melee"):
			var mousePos = get_global_mouse_position()
			var player : CharacterBody2D = get_parent().get_parent()
			var direction = (mousePos - player.position).normalized()
			var angle = direction.angle()
			raycast.target_position = direction * meleeRange
			raycast.force_raycast_update()
			var enemy = raycast.get_collider()
			if enemy:
				enemy.damageSelf(meleeDamage, meleeKnockback)
	if melee:
		if Input.is_action_just_pressed("shoot"):
			var mousePos = get_global_mouse_position()
			var player : CharacterBody2D = get_parent().get_parent()
			var direction = (mousePos - player.position).normalized()
			var angle = direction.angle()
			raycast.target_position = direction * 9999
			raycast.force_raycast_update()
			var enemy = raycast.get_collider()
			if enemy:
				enemy.damageSelf(rangeDamage, 0)
