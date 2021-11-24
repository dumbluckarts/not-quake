extends Spatial

onready var spawn_points: Array = []

func _ready():
	
	for child in get_children():
		var pos = child.global_transform.origin
		spawn_points.append(pos)

func get_random_spawn_point():
	if spawn_points.empty():	return Vector3(0.1,2,0) # if no spawn points are set then just spawn at the origin of the map
	var r = randi() % spawn_points.size()
	var sp = spawn_points[r]
	return sp
