extends CharacterBody2D

class_name Enemy

@export_group("status")
@export var ai : bool = true
@export var health : int  = 100

@export_group("movement")
@export var speed : float = 275.0
@export var sight : float = 2000.0
@export var slow_down_sight : float = 150.0
@export_range(0, 4, 0.02) var knockbackEffect : float = 0.25 # how much does knockback effect

@export_group("attacking")
@export var attackSpeed : float = 2.0
@export var attackRange : float = 50.0
@export var attackDamage : int = 5

var player_pos
var target_pos
var attackTimer
var damageIndicator = 0

@onready var player = $"../Player"

func _ready() -> void:
	attackTimer = get_tree().create_timer(0)

func _physics_process(delta: float) -> void:
	if ai:
		player_pos = player.position
		target_pos = (player_pos - position).normalized()

		if position.distance_to(player_pos) <= slow_down_sight:
			velocity.x = target_pos.x * speed * 0.8
			velocity.y = target_pos.y * speed * 0.8
		elif position.distance_to(player_pos) <= sight:
			velocity.x = target_pos.x * speed
			velocity.y = target_pos.y * speed
	move_and_slide()
	velocity /= 1.25

func _process(delta: float) -> void:
	modulate.g8 = 255-damageIndicator*255
	modulate.b8 = 255-damageIndicator*255
	if damageIndicator > 0.00001:
		damageIndicator /= 1 + delta*1.5
	else:
		damageIndicator = 0
	if ai:
		player_pos = player.position
		target_pos = (player_pos - position).normalized()

		if position.distance_to(player_pos) <= attackRange and attackTimer.time_left == 0:
			attackTimer = get_tree().create_timer(attackSpeed)
			attackTimer.connect("timeout", dealDamage)

func dealDamage():
	if position.distance_to(player_pos) <= attackRange and attackTimer.time_left == 0:
		player.dealDamage(attackDamage)

func damageSelf(amount, knockback: float):
	health -= amount
	velocity = (position - player.position).normalized() * knockback / knockbackEffect
	if health <= 0:
		ai = false
		var death_timer = get_tree().create_timer(1)
		death_timer.connect("timeout", queue_free)
	damageIndicator = 1
