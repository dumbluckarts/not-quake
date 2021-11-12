extends RigidBody

export var HEALTH = 10
export var BASE_BULLET_BOOST = 10

func damage(damage, transform = null):
	HEALTH -= damage
	
	if transform != null:
		var direction_vect = transform.basis.z.normalized() * -BASE_BULLET_BOOST;
		apply_impulse((transform.origin - global_transform.origin).normalized(), direction_vect * damage)
	
	if HEALTH <= 0: queue_free()
