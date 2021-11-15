extends Spatial

export var MOVE_SPEED = 900 #40
export var GRAV_SPEED = 60 #300
export var JUMP_SPEED = 3500 #100
export var AIR_FRICTION = 0.75
export var GROUND_FRICTION = 0.1
export var MAX_INCLINE = 60

var velocity = Vector3.ZERO
var moving = false
var jumping = false
var falling = false
var impulse = Vector3.ZERO # flag for if body is undergoing an impulse (ie by a jump pad)

func get_v(): return velocity
func is_moving(): return moving
func is_jumping(): return jumping
func is_falling(): return falling
func is_impulse(): return impulse

func set_impulse(amount: Vector3): impulse = amount

func process(body: KinematicBody, delta: float, basis: Basis):
	var input = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	).normalized()
	
	var speed = Vector3.ZERO
	var forward = basis.z
	var right = basis.x
	var normal = $RayCast_Normal.get_collision_normal()
	var relative = (forward * input.y + right * input.x)
	var move_speed = MOVE_SPEED * (1.0 if $RayCast_Normal.is_colliding() else AIR_FRICTION)
	
	relative.y = 0
	relative = relative.normalized()
	
	moving = input != Vector2.ZERO
	
	speed.x = relative.x * move_speed
	speed.z = relative.z * move_speed
	speed.y = -GRAV_SPEED
	
	velocity.x = speed.x # vertical
	velocity.z = speed.z # horizontal
	velocity.y += speed.y * delta
	#velocity.y = 0 if body.is_on_floor() or $RayCast.is_colliding() else velocity.y + speed.y
	#velocity.y = 0 if $RayCast_Celing.is_colliding() and velocity.y > 0 else velocity.y
	
	if is_impulse():
		velocity = impulse
	if (not jumping and $RayCast_Normal.is_colliding()) or velocity.y > 0:
		falling = false
	else:
		falling = true
	
	if jumping and $RayCast_Normal.is_colliding():
		jumping = false
	
	if Input.is_action_just_pressed("move_jump") and $RayCast_Normal.is_colliding():
		jumping = true
		velocity.y = JUMP_SPEED
	
	velocity.x = lerp(velocity.x, 0, GROUND_FRICTION)
	velocity.z = lerp(velocity.z, 0, GROUND_FRICTION)
	
	var snap = Vector3.DOWN if not is_jumping() else Vector3.ZERO
	velocity = body.move_and_slide_with_snap(velocity, snap, Vector3.UP, true, 4 , deg2rad(MAX_INCLINE))

"""
func process(body: KinematicBody, delta: float, basis: Basis):
	var input = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	).normalized()
	
	var speed = Vector3.ZERO
	var forward = basis.z
	var right = basis.x
	var normal = $RayCast_Normal.get_collision_normal()
	var relative = (forward * input.y + right * input.x)
	var move_speed = MOVE_SPEED * (1.0 if $RayCast_Normal.is_colliding() else 0.8)
	
	relative.y = 0
	relative = relative.normalized()
	
	moving = input != Vector2.ZERO
	
	speed.x = relative.x * move_speed
	speed.z = relative.z * move_speed
	speed.y = -GRAV_SPEED
	
	velocity.x += speed.x # vertical
	velocity.z += speed.z # horizontal
	 
	velocity.y = 0 if body.is_on_floor() or $RayCast.is_colliding() else velocity.y + speed.y
	velocity.y = 0 if $RayCast_Celing.is_colliding() and velocity.y > 0 else velocity.y
	
	if is_impulse():
		velocity += impulse
	
	if Input.is_action_just_pressed("move_jump") and $RayCast_Normal.is_colliding():
		velocity.y = JUMP_SPEED
	
	velocity.x = lerp(velocity.x, 0, 0.2)
	velocity.z = lerp(velocity.z, 0, 0.2)
	
	body.move_and_slide(velocity * delta, Vector3.UP)

"""
