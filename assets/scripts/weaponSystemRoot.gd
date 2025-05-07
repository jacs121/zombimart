extends Node2D
class_name Weapon

@export_group("weapon")
@export var weaponName: String

@onready var raycast:RayCast2D = $"../raycast"

func _ready():
	pass

func getMouseDirection(): 
	return (get_global_mouse_position() - get_parent().get_parent().position).normalized()

func attack(range: float, callbackHit: Callable):
	# calculate the angle of the mouse from the player
	var direction = getMouseDirection()

	raycast.target_position = direction * range # set the target position to the melee range in the diraction of the mouse
	raycast.force_raycast_update() # shoot a ray
	var enemy = raycast.get_collider() # get collided object (or none)
	# if hit an enemy damage it
	if enemy:
		return callbackHit.call(enemy)
