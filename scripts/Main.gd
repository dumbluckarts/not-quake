extends Spatial

export var fast_close := true # Enables closing with 'Esc'
var mouse_mode: String = "CAPTURED" # Change mouse mode by clicking 'Shift + F1'

func _ready() -> void:
	if fast_close:
		print("** Fast Close enabled in the 'Main.gd' script **")
		print("** 'Esc' to close 'Shift + F1' to release mouse **")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and fast_close:
		get_tree().quit()
	
	if event.is_action_pressed("mouse_input") and fast_close:
		match mouse_mode:
			"CAPTURED":
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				mouse_mode = "VISIBLE"
			"VISIBLE":
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				mouse_mode = "CAPTURED"
