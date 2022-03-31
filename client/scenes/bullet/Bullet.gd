extends Area2D

export var speed: float = 20

func _ready():
	$CollisionShape2D.set_deferred("disabled", 0)

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_Bullet_body_entered(body):
	# check area's group to see if its damageable, emit damage signal and destroy self
	if body.is_in_group('damageable'):
		# emit signal
		pass
	queue_free()
