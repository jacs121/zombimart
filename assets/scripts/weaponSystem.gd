extends Node2D

@export_group("weapon")
@export var weaponName: String
@export var weaponTexture: Texture2D
@export var meleeCooldown: float = 0
@export var rangeCooldown: float = 0
@onready var raycast:RayCast2D = $"../raycast"

@export_group("melee")
@export var melee: bool = false
@export var meleeDamage: int = 0
@export var meleeRange: int = 36
@export var meleeKnockback: int = 0

@export_group("range")
@export var range: bool = false
@export var rangeProjectile: PackedScene
@export var rangeDamage: int
@export var rangeSpeed: float

func _ready():
	pass

func _process(delta):
	if visible == true:
		if melee:
			if Input.is_action_just_pressed("melee"): # when player presses the "melee" key
				var mousePos = get_global_mouse_position() # get mouse pos on the screen
				var player : CharacterBody2D = get_parent().get_parent() # get the player character
				# calculate the angle of the mouse from the player
				var direction = (mousePos - player.position).normalized()

				raycast.target_position = direction * meleeRange # set the target position to the melee range in the diraction of the mouse
				raycast.force_raycast_update() # shoot a ray
				var enemy = raycast.get_collider() # get collided object (or none)
				# if hit an enemy damage it
				if enemy:
					enemy.damageSelf(meleeDamage, meleeKnockback)
		if range:
			if Input.is_action_just_pressed("shoot"): # when player presses the "shoot" key
				var mousePos = get_global_mouse_position() # get mouse pos on the screen
				var player : CharacterBody2D = get_parent().get_parent() # get the player character
				# calculate the angle of the mouse from the player
				var direction = (mousePos - player.position).normalized()
				var projectile: Node2D = rangeProjectile.instantiate()
				projectile.position = direction
				projectile.setDirection(direction, rangeSpeed)
				$"..".add_child(projectile)

				var enemy = raycast.get_collider() # get collided object (or none)
				# if hit an enemy damage it
				if enemy:
					enemy.damageSelf(rangeDamage, 0)
