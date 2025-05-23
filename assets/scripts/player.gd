extends CharacterBody2D

class_name Player

@export_group("movement")
@export var canMove: bool = true
@export var SPEED: float = 300.0


@export_group("Health")
var health: float = 0
@export var maxHealth: int = 100
@onready var healthBar : ProgressBar = $GUI/healthBar
@export var green : Color
@export var red : Color

var damageIndicator = 0


func _ready():
	health = maxHealth

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_vector("left", "right", "up", "down").normalized() * int(canMove)
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

func _process(delta):
	modulate.g8 = 255-damageIndicator*255
	modulate.b8 = 255-damageIndicator*255
	if damageIndicator > 0.00001:
		damageIndicator /= 1 + delta*1.5
	else:
		damageIndicator = 0
	healthBar.set_value(health) # set the helath bar to match the health of the player
	healthBar.get("theme_override_styles/fill").bg_color = green.lerp(red, 1-health/maxHealth) # set the color of the health bar from green to red (from 100 hp to 0hp)
	# reset the scene one second after the player's health gets to 0
	if health == 0:
		hide()
		get_tree().create_timer(1).connect("timeout", get_tree().reload_current_scene)

func dealDamage(value: int): # damage the player
	health -= value
	damageIndicator = 1
