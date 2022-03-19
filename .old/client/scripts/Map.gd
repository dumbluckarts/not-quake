extends Spatial
class_name Map

func get_spawn():
	return $"Spawn Points".get_random_spawn_point()
