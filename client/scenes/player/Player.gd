extends KinematicBody2D
export (PackedScene) var BULLET
	
func _physics_process(delta):
	$Movement.process(self, delta)



# TODO: Move to gun?
func shoot():
	$"../Camera2D".shake_strength = 2.0
	var bullet = BULLET.instance()
	owner.add_child(bullet)
	bullet.transform = $Gun/Muzzle.global_transform

