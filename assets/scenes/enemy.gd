extends CharacterBody2D

@export var speed : float = 300.0
@export var sight : float = 2000.0
@export var slow_down_sight : float = 150.0

var player_pos
var target_pos

@onready var player = $"../Player"

func _ready() -> void:
	if player != null:
		print("FOUND PLAYER")

func _physics_process(delta: float) -> void:
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
