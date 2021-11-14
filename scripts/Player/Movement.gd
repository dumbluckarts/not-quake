extends Spatial

export var MOVE_SPEED = 1000
export var GRAV_SPEED = 60
export var JUMP_SPEED = 5000

var velocity = Vector3.ZERO
var moving = false

func get_v(): return velocity
func is_moving(): return moving
func is_jumping(): return velocity.y > 0
func is_falling(): return velocity.y < 0

func process(body: KinematicBody, delta: float, basis: Basis):
	var input = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	).normalized()
	
	var speed = Vector3.ZERO
	var forward = basis.z
	var right = basis.x
	
	var relative = (forward * input.y + right * input.x)
	var move_speed = MOVE_SPEED * (1.0 if $RayCast.is_colliding() else 0.8)
	
	moving = input != Vector2.ZERO
	
	speed.x = relative.x * move_speed
	speed.z = relative.z * move_speed
	speed.y = -GRAV_SPEED

	velocity.x += speed.x # vertial
	velocity.z += speed.z # horizontal
	velocity.y = 0 if $RayCast.is_colliding() else velocity.y + speed.y
	
	if Input.is_action_pressed("move_jump") and $RayCast.is_colliding():
		velocity.y = JUMP_SPEED
	
	velocity.x = lerp(velocity.x, 0, 0.2)
	velocity.z = lerp(velocity.z, 0, 0.2)
	
	body.move_and_slide(velocity * delta, Vector3.ZERO)
