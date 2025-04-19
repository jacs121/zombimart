extends RayCast2D

func _input(event):
	if event is InputEventMouseMotion:
		var mousePos = get_global_mouse_position()
		var player : CharacterBody2D = get_parent().get_parent()
		rotation_degrees = rad_to_deg(((mousePos.y - player.position.y)/(mousePos.x - player.position.y)))
		print(rotation_degrees)
