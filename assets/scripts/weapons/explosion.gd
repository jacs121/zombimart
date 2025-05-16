extends Area2D

var damage

func _on_body_entered(area):
	if area.is_in_group("player"):
		area.dealDamage(damage)
	elif area.is_in_group("enemy"):
		area.damageSelf(damage, 0)

func disableCollision():
	set_collision_layer_value(1, 0)
	set_collision_layer_value(3, 0)
	set_collision_layer_value(4, 0)
	set_collision_mask_value(1, 0)
	set_collision_mask_value(3, 0)
	set_collision_mask_value(4, 0)

func _ready():
	$ExplosinAnimation.global_position = global_position
	get_tree().create_timer(0.075).timeout.connect(disableCollision)
	$ExplosinAnimation.animation_finished.connect(queue_free)
	$ExplosinAnimation.scale = Vector2($CollisionShape2D.shape.radius/28,$CollisionShape2D.shape.radius/28)
