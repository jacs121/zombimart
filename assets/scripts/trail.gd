extends Line2D

@export var maxLength: int = 10
var queue: Array

func _process(delta):
	var pos = position
	queue.push_front(pos)
	
	if queue.size() > maxLength:
		queue.pop_back()

	clear_points()
	for point in queue:
		add_point(point)
