extends Weapon

var cooldown = 0

func _process(delta):
	if cooldown > 0:
		cooldown = max(cooldown - delta, 0)

func _input(event):
	if visible == false:
		return
	if event.is_action_pressed("shoot") and cooldown == 0:
		var proj = preload("res://assets/scenes/projectiles/bullet.tscn")
		proj = proj.instantiate()
		proj.direction = getMouseDirection()
		proj.global_position = global_position
		get_parent().get_parent().get_parent().add_child(proj)
		cooldown = 1.5
