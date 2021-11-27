extends Spatial
class_name PlayerInventory

var hands = {
	"PISTOL":null,
	"PRIMARY":null,
	"ARMOR":null
}

var bag = {
	'1':null,
	'2':null,
	'3':null,
	'4':null,
	'5':null,
	'6':null
}

func _process(delta):
	if Input.is_action_just_pressed("tab"):
			toggle_inv()

func toggle_inv():
	var a = InputEventAction.new()
	a.action = "mouse_input"
	a.pressed = true
	Input.parse_input_event(a)
	var visible = not $"../CanvasLayer/Inventory".visible
	$"../CanvasLayer/Inventory".visible = visible
	get_parent().inventory_open = visible
	a.pressed = false

# if the inventory "x" button is pressed
func _on_Button_pressed():
	toggle_inv()