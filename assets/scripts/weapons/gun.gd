extends Weapon


var cooldown = 0

func _ready():
	weaponName = "gun"

func _process(delta):
	if cooldown > 0:
		cooldown = max(cooldown - delta, 0)

func _input(event):
	if visible == false:
		return
	if event.is_action_pressed("shoot") and cooldown == 0:
		var proj = preload("res://assets/scenes/projectileRoot.tscn")
		proj = proj.instantiate()
		proj.damage = 10
		proj.direction = getMouseDirection()
		proj.global_position = global_position
		proj.speed = 300
		get_parent().get_parent().get_parent().add_child(proj)
		cooldown = 1.5
