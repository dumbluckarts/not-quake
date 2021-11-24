extends Spatial

func _process(delta):
	if Input.is_action_just_pressed("tab"):
			toggle_inv()

func toggle_inv():
	var a = InputEventAction.new()
	a.action = "mouse_input"
	a.pressed = true
	Input.parse_input_event(a)
	var visible = not $"../../CanvasLayer/Inventory".visible
	$"../../CanvasLayer/Inventory".visible = visible
	get_parent().inventory_open = visible
	a.pressed = false
