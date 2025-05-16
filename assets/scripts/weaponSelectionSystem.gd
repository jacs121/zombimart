extends Node2D

var weaponChilds
var selectedWeaponIndex = 0

@export var rayCast: RayCast2D

# Called when the node enters the scene tree for the first time.
func _ready():
	weaponChilds = get_children() # put all the weapon objects in a list
	# loop over the weapons
	for weaponChild in weaponChilds:
		if weaponChild.get_class() == rayCast.get_class():
			weaponChilds.erase(weaponChild) # if it's not remove it from the weapons list
		else:
			weaponChild.visible = false # if it's a weapon hide it
	weaponChilds[0].visible = true # show the first weapon

func _input(event):
	if Input.get_axis("next_weapon", "previous_weapon") != 0 and get_parent().canMove: # check if the mouse wheel is moved
		weaponChilds[selectedWeaponIndex].visible = false # hide the current weapon
		selectedWeaponIndex += Input.get_axis("next_weapon", "previous_weapon") # add 1 or -1 depending on if it's mouse wheel up or down
		selectedWeaponIndex = fmod(selectedWeaponIndex, len(weaponChilds)) # loop it in the range of the weapons list
		print(weaponChilds[selectedWeaponIndex].name) # debug
		weaponChilds[selectedWeaponIndex].visible = true # show the new weapon
