extends Node

export var SERVER_NAME: String = "Server" 
export var MAX_PLAYERS: int = 5
export var PORT: int = 4464

onready var network = get_node("/root/Network")

# Called when the node enters the scene tree for the first time.
func _ready():
	network.connect("server_created", self, "_on_ready_to_play")
	network.connect("join_success", self, "_on_player_join")
	_start()

func _start():
	network.server_info.name = SERVER_NAME
	network.server_info.max_players = MAX_PLAYERS
	network.server_info.port = PORT


func _on_ready_to_play():
	#get_tree().change_scene("res://Main.tscn")
	print("Game Started")

func _on_player_join():
	print("Player Joined")
