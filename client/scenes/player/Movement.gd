extends Node2D

export var MOVE_SPEED = 40
export var HITPUNCH_SCALAR = 1.0
export var SNEAK_SCALAR = 2.0

var velocity = Vector3.ZERO
var moving = false
var impulse = Vector3.ZERO # flag for if body is undergoing an impulse (ie by a jump pad)

func get_v(): return velocity
func is_moving(): return moving
func is_impulse(): return impulse

func set_impulse(amount: Vector3): impulse = amount

func process(body: KinematicBody2D, delta: float):
	var input = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	).normalized()
	
	var speed = Vector2.ZERO
	var move_speed = MOVE_SPEED
	
	if Input.is_action_pressed("move_sneak"):
		move_speed /= SNEAK_SCALAR
	
	moving = input != Vector2.ZERO
	
	speed = input * move_speed * HITPUNCH_SCALAR
	
	HITPUNCH_SCALAR = lerp(HITPUNCH_SCALAR, 1, 0.025)
	
	velocity = body.move_and_slide(speed, Vector2.UP)
