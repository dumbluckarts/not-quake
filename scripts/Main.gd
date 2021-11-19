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
	var enemy = load("res://godot/scenes/enemies/Enemy.tscn").instance()
	enemy.name = str(data['id'])
	$Enemies.add_child(enemy)

func _on_update_client(data: Dictionary):
	for key in data.keys():
		if $Enemies.has_node(key): continue
		var pls = data[key]
		var enemy = $Enemies.get_node(key)
		
		if 'data' in pls: 
			var pos = Vector3.ZERO
			var pos_data = pls['data']['position'] as String
			
			pos_data.substr(1)
			pos_data.substr(0, pos_data.length() - 1)
		
			var pos_split = pos_data.split(',')
			var x = pos_split[0]
			var y = pos_split[1]
			var z = pos_split[2]
			
			var vec = Vector3(x, y, z)
			
			enemy.global_transform.origin = vec
		
		
#	for child in $Enemies.get_children():
#		var id = child.get_meta('id')
#		var pos = data[id]['data']['position']
#
#		child.global_transform.origin = pos
