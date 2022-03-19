extends Spatial

export var MIN_PLAYERS = 10

var timer = Timer.new()
var player_list = []

func _ready():
	timer.autostart = true
	timer.one_shot = false
	timer.wait_time = 5
	timer.connect("timeout", self, "update_client_list")
	add_child(timer)


func update_client_list():
	var client_list = $"../../Enemies".get_children()
	for enemy in client_list:
		if not enemy in player_list:
			print(enemy.name + " Joined")
			player_list.append(enemy)
	start_game()

func start_game():
	if player_list.size() < MIN_PLAYERS: return # wait for more players to join
	get_tree().reload_current_scene()

func end_game():
	get_tree()
