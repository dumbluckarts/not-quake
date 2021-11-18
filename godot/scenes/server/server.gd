extends Node

signal join_success
signal join_fail

export var SERVER_NAME: String = "Server" 
export var MAX_PLAYERS: int = 5
export var PORT: int = 4464


func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	_start()

func _start():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(PORT, MAX_PLAYERS)
	get_tree().network_peer = peer
	
	print("Server listening on PORT: %s" %PORT)

func _player_connected(id):
	emit_signal("join_success")
	print("Connected %s" % id)
	
func _player_disconnected(id):
	emit_signal("join_fail")
	print("Disconnected %s" % id)
