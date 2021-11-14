extends Spatial

export var MOVE_SPEED = 1000
export var GRAV_SPEED = 60
export var JUMP_SPEED = 5000

var velocity = Vector3.ZERO
var moving = false
var impulse = 0 # flag for if body is undergoing an impulse (ie by a jump pad)

func get_v(): return velocity
func is_moving(): return moving
func is_jumping(): return velocity.y > 0
func is_falling(): return velocity.y < 0
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
	
	body.move_and_slide(velocity * delta, Vector3.UP, true)
