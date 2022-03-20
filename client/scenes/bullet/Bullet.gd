extends Area2D

var hit = false

func _ready():
	$CollisionShape2D.set_deferred("disabled", 0)

func shoot(velocity: Vector2, delta):
	while not hit:
		# this is an autist implementation
		position = lerp(velocity, position+velocity, 1)

func _on_Bullet_area_entered(area):
	# check area's group to see if its damageable, emit damage signal and destroy self
	pass 
