extends Camera2D
class_name Cam

var enabled = true
var shake_strength = 0
var zoom_weight = 0.1

onready var zoom_original = zoom

func _physics_process(_delta):
	if not enabled: return
	shake_strength = lerp(shake_strength, 0, 0.05)
	global_position.x = lerp(global_position.x + rand_range(-shake_strength, shake_strength), $"../Player".global_position.x, 0.35)
	global_position.y = lerp(global_position.y + rand_range(-shake_strength, shake_strength), $"../Player".global_position.y, 0.35)
	zoom = zoom.linear_interpolate(zoom_original, zoom_weight)
