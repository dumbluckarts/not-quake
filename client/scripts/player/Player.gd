extends KinematicBody2D



func _process(delta):
	$Gun.look_at(get_global_mouse_position())
	$Sprite.flip_h = get_local_mouse_position().x < 0
	$Gun.flip_v = get_local_mouse_position().x < 0
	
	if Input.is_action_pressed("shoot"):
		$"../Camera2D".shake_strength = 2.0

func _physics_process(delta):
	$Movement.process(self, delta)
