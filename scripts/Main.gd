extends Spatial

var mouse_mode: String = "CAPTURED" # Change mouse mode by clicking 'Shift + F1'
var _clients: Dictionary

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	Client.connect("update_client", self, "_on_update_client")
	Client.connect("ready_client", self, "_on_ready_client")
	Client.send('ready_client')

func _physics_process(_delta):
	Client.send("update_client", { 'position': $Player.global_transform.origin })

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	
	if event.is_action_pressed("mouse_input"):
		match mouse_mode:
			"CAPTURED":
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				mouse_mode = "VISIBLE"
			"VISIBLE":
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				mouse_mode = "CAPTURED"

func _on_ready_client(data):
	var enemy = load("res://godot/scenes/enemies/Enemy.tscn")
	$Enemies.add_child(enemy.set_meta("id", data['id']))

func _on_update_client(data):
	for child in $Enemies.get_children():
		var id = child.get_meta('id')
		var pos = data[id]['data']['position']
		
		child.global_transform.origin = pos
