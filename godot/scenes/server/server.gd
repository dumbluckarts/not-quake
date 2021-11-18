extends Node

export var SERVER_NAME: String = "Server" 
export var MAX_PLAYERS: int = 5
export var PORT: int = 4464

# Called when the node enters the scene tree for the first time.
func _ready():
	Network.connect("server_created", self, "_on_ready_to_play")
	Network.connect("join_success", self, "_on_player_join")
	_start()

func _start():
	Network.server_info.name = SERVER_NAME
	Network.server_info.max_players = MAX_PLAYERS
	Network.server_info.port = PORT
	print("Server listening on PORT:" + str(PORT))

func _on_ready_to_play():
	#get_tree().change_scene("res://Main.tscn")
	print("Game Started")

func _on_player_join():
	print("Player Joined")
