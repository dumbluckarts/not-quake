extends KinematicBody2D
export (PackedScene) var BULLET

func _process(_delta):
	$Gun.look_at(get_global_mouse_position())
	$Sprite.flip_h = get_local_mouse_position().x < 0
	$Gun.flip_v = get_local_mouse_position().x < 0
	
	if Input.is_action_pressed("shoot"):
		shoot()
	
func _physics_process(delta):
	$Movement.process(self, delta)

# TODO: Move to gun?
func shoot():
	$"../Camera2D".shake_strength = 2.0
	var bullet = BULLET.instance()
	owner.add_child(bullet)
	bullet.transform = $Gun/Muzzle.global_transform

