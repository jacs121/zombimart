extends Node2D

var weaponChilds
var selectedWeaponIndex = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	weaponChilds = get_children()
	for weaponChild in weaponChilds:
		weaponChild.hide()
	weaponChilds[0].show()

func _input(event):
	if Input.get_axis("next_weapon", "previous_weapon") != 0:
		weaponChilds[selectedWeaponIndex].hide()
		selectedWeaponIndex += Input.get_axis("next_weapon", "previous_weapon")
		selectedWeaponIndex = fmod(selectedWeaponIndex, len(weaponChilds))
		print(weaponChilds[selectedWeaponIndex].name)
		weaponChilds[selectedWeaponIndex].show()
	if event is InputEventMouseButton:
		var mousePos = event.position
		var player = $"."
		$meleeRange.rotation_degrees = rad_to_deg(((mousePos.y - player.position.y)/(mousePos.x - player.position.y)))
		print($meleeRange.rotation_degrees)
