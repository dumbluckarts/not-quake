extends Sprite

func _ready():
	yield(get_tree().create_timer(0.1), "timeout")
	queue_free()

func _physics_process(delta):
	scale.x += 5 * delta
	scale.y += 5 * delta
