extends MeshInstance

var direction: Vector3
var speed: int
var original: Vector3
var distance: float

func _ready():
	original = global_transform.origin

func _physics_process(delta):
	global_transform.origin += (direction * speed) * delta 
	distance = global_transform.origin.distance_to(original)
	if distance > 100: queue_free()
