extends Node

export var SERVER_NAME: String = "Server" 
export var MAX_PLAYERS: int = 5
export var PORT: int = 4464

# Called when the node enters the scene tree for the first time.
func _ready():
	Network.connect("server_created", self, "_on_ready_to_play")
	Network.connect("join_success", self, "_on_player_join")
	Network.connect("network_peer_connected", self, "_player_connected")
	Network.connect("network_peer_disconnected", self, "_player_disconnected")
	_start()

func _start():
#	Network.server_info.name = SERVER_NAME
#	Network.server_info.max_players = MAX_PLAYERS
#	Network.server_info.port = PORT
#	Network.create_server()
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(PORT, MAX_PLAYERS)
	get_tree().network_peer = peer
	
	print("Server listening on PORT: %s" %PORT)

func _player_connected(id):
	print("Connected %s" % id)
	
func _player_disconnected(id):
	print("Connected %s" % id)
	
func _on_ready_to_play():
	#get_tree().change_scene("res://Main.tscn")
	print("Game Started")

func _on_player_join():
	print("Player Joined")
