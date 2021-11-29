extends Spatial
class_name PlayerInventory

export(NodePath) var RAYCAST

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

var hovering = null

func _process(delta):
	if Input.is_action_just_pressed("tab"):
			toggle_inv()
				# temporary UI enabler for pickupable items
				
	# Item pickups
	var collider = get_node(RAYCAST).get_collider()
	
	if collider and collider.is_in_group("pickupable"):
		hovering = collider.get_parent().get_parent()
		Game.get_interface_node("Crosshair/Select").visible = true
	else:
		Game.get_interface_node("Crosshair/Select").visible = false
		hovering = null

	if Input.is_action_just_pressed("interact") and hovering != null:
		hovering.queue_free()

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
