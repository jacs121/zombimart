extends CharacterBody2D

var player : Node2D

@export var explosionTime : float

@export var size : float = 50
@export var damage : int
@export var acceleration : float
@export var maxSpeed : float

func _ready() -> void:
	$Sprite2D.scale = Vector2(size, size)/$Sprite2D.get_rect().size
	$CollisionShape2D.shape.size = Vector2(size, size)
	player = get_tree().get_first_node_in_group("player")

	player.canMove = false
	player.get_node("Camera").enabled = false
	$carCamera.enabled = true

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
	player.canMove = true
	player.get_node("Camera").enabled = true
	$carCamera.enabled = false
	get_tree().current_scene.explosion(size*1.5, damage, global_position)
	queue_free()

func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	_Destroy()
