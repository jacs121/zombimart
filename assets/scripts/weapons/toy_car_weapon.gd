extends CharacterBody2D

var player : Node2D

@export var explosionTime : float

@export var radius : float
@export var damage : int

@export var acceleration : float

@export var maxSpeed : float

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player") as Player
	
	player.canMove = false
	
	player.hide()
	
	get_tree().create_timer(explosionTime).timeout.connect(_Destroy)

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if(direction != Vector2.ZERO):
		velocity += direction.normalized() * acceleration * delta
		velocity = velocity.limit_length(maxSpeed)
	else:
		velocity = velocity.lerp(Vector2.ZERO, 0.05)
	
	move_and_slide()
	
func _Destroy() -> void:
	
	player.show()
	
	player.canMove = true
	
	(get_tree().current_scene as Utils).explosion(radius, damage, global_position)
	
	queue_free()

func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	_Destroy()
