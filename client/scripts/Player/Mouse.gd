extends Spatial
class_name PlayerMouse

export var MOUSE_SENSITIVITY = 0.0
export var MOUSE_Y_LIMIT = Vector2.ZERO

var relative = Vector2()
var hovering = null

func process(spatial: Spatial, delta: Vector2):
	relative = delta
	
	# top down camera
	spatial.rotation_degrees.x -= delta.y * MOUSE_SENSITIVITY
	spatial.rotation_degrees.x = clamp(spatial.rotation_degrees.x, MOUSE_Y_LIMIT.x, MOUSE_Y_LIMIT.y)

	# left right camera
	spatial.rotation_degrees.y -= delta.x * MOUSE_SENSITIVITY
