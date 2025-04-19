extends CharacterBody2D

@export var speed : int
@export var sight : float

var player_pos
var target_pos

@onready var player = $"../Player"

func _ready() -> void:
	if player != null:
		print("FOUND PLAYER")

func _physics_process(delta: float) -> void:
	player_pos = player.position
	target_pos = (player_pos - position).normalized()
	
	if position.distance_to(player_pos) > sight:
		velocity.x = target_pos.x * speed
		velocity.y = target_pos.y * speed
		move_and_slide()
