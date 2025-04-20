extends CharacterBody2D

@export var ai : bool = true
@export_group("movement")
@export var speed : float = 275.0
@export var sight : float = 2000.0
@export var slow_down_sight : float = 150.0

@export_group("attacking")
@export var attackSpeed : float = 2.0
@export var attackRange : float = 50.0
@export var attackDamage : int = 5

var player_pos
var target_pos
var attackTimer

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
			move_and_slide()

		elif position.distance_to(player_pos) <= sight:
			velocity.x = target_pos.x * speed
			velocity.y = target_pos.y * speed
			move_and_slide()

func _process(delta: float) -> void:
	if ai:
		player_pos = player.position
		target_pos = (player_pos - position).normalized()

		if position.distance_to(player_pos) <= attackRange and attackTimer.time_left == 0:
			attackTimer = get_tree().create_timer(attackSpeed)
			attackTimer.connect("timeout", dealDamage)

func dealDamage():
	if position.distance_to(player_pos) <= attackRange and attackTimer.time_left == 0:
		player.dealDamage(attackDamage)
