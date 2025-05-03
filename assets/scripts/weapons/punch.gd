extends Weapon

func _ready():
	weaponName = "Punch"


func _input(event):
	if visible == false:
		return
	if event.is_action_pressed("melee"):
		attack(50, hit)

func hit(enemy):
	enemy.damageSelf(5, 10)
