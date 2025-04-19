extends CharacterBody2D

const SPEED = 300.0

@export var maxHealth: int = 100
var health: int = 0
@onready var healthBar = $GUI/healthBar

func _ready():
	health = maxHealth

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("left", "right", "up", "down").normalized()
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

func _process(delta):
	healthBar.set_value(health)

func dealDamage(value: int):
	health -= value
