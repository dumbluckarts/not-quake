extends KinematicBody

var NHHC = preload("res://godot/scenes/interface/weapons/030 NHHC.tscn")
var AR = preload("res://godot/scenes/interface/weapons/1337 AR.tscn")
var FSL = preload("res://godot/scenes/interface/weapons/FSL 23837.tscn")
var PUMP = preload("res://godot/scenes/interface/weapons/PUMP 4.tscn")
var SUS = preload("res://godot/scenes/interface/weapons/SUS.tscn")
var PARTICLES = preload("res://godot/scenes/effects/ParticlesBlood.tscn")

func damage(amount: int, transform: Transform):
	var nhhc = NHHC.instance()
	var ar = AR.instance()
	var fsl = FSL.instance()
	var pump = PUMP.instance()
	var sus = SUS.instance()
	var particles = PARTICLES.instance()
	
	Game.get_map().add_child(nhhc)
	Game.get_map().add_child(ar)
	Game.get_map().add_child(fsl)
	Game.get_map().add_child(pump)
	Game.get_map().add_child(sus)
	Game.get_map().add_child(particles)
	
	nhhc.global_transform.origin = global_transform.origin
	nhhc.apply_central_impulse(Vector3(rand_range(-10, 10), rand_range(10, 15), rand_range(-10, 10)))
	ar.global_transform.origin = global_transform.origin
	ar.apply_central_impulse(Vector3(rand_range(-10, 10), rand_range(10, 15), rand_range(-10, 10)))
	fsl.global_transform.origin = global_transform.origin
	fsl.apply_central_impulse(Vector3(rand_range(-10, 10), rand_range(10, 15), rand_range(-10, 10)))
	pump.global_transform.origin = global_transform.origin
	pump.apply_central_impulse(Vector3(rand_range(-10, 10), rand_range(10, 15), rand_range(-10, 10)))
	sus.global_transform.origin = global_transform.origin
	sus.apply_central_impulse(Vector3(rand_range(-10, 10), rand_range(10, 15), rand_range(-10, 10)))
	particles.global_transform.origin = global_transform.origin
	particles.emitting = true
	
	queue_free()
