extends Label

var offset: Vector2
var hovering = false

func _ready():
	visible = false
	offset = Vector2(rand_range(-32, 32), rand_range(-32, 32))

func _process(delta):
	
	var camera = Game.get_camera() as Camera
	var player = Game.get_player() as Player
	var item = $"../../MeshInstance" as Spatial
	var offset = Vector2(0, -32)
	var position = camera.unproject_position(item.global_transform.origin)
	var distance = player.global_transform.origin.distance_to(item.global_transform.origin)
	
	visible = distance < 10 and item.get_parent().is_on_screen()
	rect_position = position + offset + self.offset
	rect_scale = rect_scale.linear_interpolate(Vector2(0.6, 0.6), 0.1)
