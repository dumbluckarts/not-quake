extends Spatial

var timer = Timer.new()
var TARGET = preload("res://godot/scenes/assets/Target.tscn")

func _ready():
	timer.autostart = true
	timer.one_shot = false
	timer.wait_time = 1
	timer.connect("timeout", self, "spawn")
	
	add_child(timer)
	
func spawn():
	var position = get_child(randi() % get_child_count())
	var target = TARGET.instance()
	
	if timer.wait_time > 0.01: timer.wait_time -= 0.01
	position.add_child(target)
