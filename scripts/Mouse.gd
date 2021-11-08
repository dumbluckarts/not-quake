extends Spatial

export var MOUSE_SENSITIVITY = 0
export var MOUSE_Y_LIMIT = Vector2.ZERO

var mouse_delta = Vector2.ZERO

func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass

func move(body: Spatial, delta):
	# top down camera
	body.rotation_degrees.x -= mouse_delta.y * MOUSE_SENSITIVITY * delta
	body.rotation_degrees.x = clamp(body.rotation_degrees.x, MOUSE_Y_LIMIT.x, MOUSE_Y_LIMIT.y)

	# left right camera
	body.rotation_degrees.y -= mouse_delta.x * MOUSE_SENSITIVITY * delta

	mouse_delta = Vector2.ZERO

func delta(delta):
	mouse_delta = delta
