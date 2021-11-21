extends Spatial

var mouse_mode: String = "CAPTURED" # Change mouse mode by clicking 'Shift + F1'
var _clients: Dictionary

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	Client.connect("update_client", self, "_on_update_client")
	Client.connect("push_client", self, "_on_push_client")
	Client.send('ready_client')

func _physics_process(_delta):
	var packet = {
		'position': {
			'x': $Player.global_transform.origin.x,
			'y': $Player.global_transform.origin.y,
			'z': $Player.global_transform.origin.z,
		},
		'camera': {
			'x': $Player.get_node('Mouse/Camera').rotation_degrees.x,
			'y': $Player.get_node("Mouse/Camera").rotation_degrees.y
		}
	}
	
	Client.send("update_client", packet)

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

func _on_update_client(data: Dictionary):
	for key in data.keys():
#		Create player if they dont exist
		if not $Enemies.has_node(key): 
			var enemy = load("res://godot/scenes/enemies/Enemy.tscn").instance()
			enemy.name = str(key)
			$Enemies.add_child(enemy)
		else:
			var pls = data[key]
			var enemy = $Enemies.get_node(key) as Spatial
			
			if 'data' in pls:
				var pos_data = pls['data']['position']
				var rot_data = pls['data']['camera']
				var pos = Vector3(pos_data['x'], pos_data['y'], pos_data['z'])
				
				enemy.global_transform.origin = enemy.global_transform.origin.linear_interpolate(pos, 0.5)
				enemy.rotation_degrees.x = rot_data['x']
				enemy.rotation_degrees.y = rot_data['y']

func _on_push_client(data: Dictionary):
	if 'damage' in data: Game.get_player().damage(int(data['damage']))
