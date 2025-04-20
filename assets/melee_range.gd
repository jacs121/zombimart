extends RayCast2D

@export var meleeRange : float

func _input(event):
	if event is InputEventMouseMotion:
		var mousePos = get_global_mouse_position()
		var player : CharacterBody2D = get_parent().get_parent()
		var direction = (mousePos - player.position).normalized()
		var angle = direction.angle()
		target_position = direction * meleeRange
		force_raycast_update()
