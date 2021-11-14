extends Node

signal hit_damagable

export(PackedScene) var BULLET
export(PackedScene) var PARTICLES
export(NodePath) var POSITION
export(NodePath) var RAYCAST
export(NodePath) var SOUND

func _ready():
	$AnimationPlayer.connect("animation_finished", self, "animate")
	$AnimationPlayer.connect("animation_finished", self, "attack")

func _process(_delta):
	if Input.is_action_just_pressed("shoot"):
		attack('')
		animate('')
	if Input.is_action_pressed("shoot"):
		$AnimationPlayer.play("shoot")
	else:
		$AnimationPlayer.play("default")

func attack(_anim):
	var raycast = get_node(RAYCAST) as RayCast
	if not raycast.is_colliding(): return
	var collider = raycast.get_collider()
	if not collider.is_in_group("damagable"): return
	
	emit_signal('hit_damagable')
	
	collider.damage(1, raycast.global_transform)
	$"../Audio/AudioStreamPlayer_Hit".pitch_scale = rand_range(0.9, 1.1)
	$"../Audio/AudioStreamPlayer_Hit".play()
	$"../Audio/AudioStreamPlayer_Hit2".play()

func animate(_anim):
	var raycast = get_node(RAYCAST)
	var position = get_node(POSITION)
	var sound = get_node(SOUND)
	var bullet = BULLET.instance() as Spatial
	$"/root/Spatial".add_child(bullet)
	bullet.global_transform.origin = position.global_transform.origin
	bullet.direction = bullet.global_transform.origin.direction_to(raycast.get_collision_point())
	bullet.look_at(raycast.get_collision_point(), Vector3.UP)
	bullet.speed = 300 + rand_range(-50, 50)
	sound.pitch_scale = rand_range(0.9, 1.1)
	sound.play()
	$"../Mouse/Camera".rotation_degrees.x += rand_range(1, 2)
	$"../Mouse/Camera".rotation_degrees.y += rand_range(-0.2, 0.2)
	
	#var particles = PARTICLES.instance()
	#$"../Mouse/Camera/Gun/Position3D_Tip".add_child(particles)
	#particles.emitting = true
