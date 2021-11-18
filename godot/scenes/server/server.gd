extends Node

signal join_success
signal join_fail
signal server_start
signal server_stop

export var SERVER_NAME: String = "Server" 
export var MAX_PLAYERS: int = 5
export var PORT: int = 4464

var server_info = {
	name = SERVER_NAME,
	max_players = MAX_PLAYERS,
	port = PORT
}

func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	

func _start():
	var peer = NetworkedMultiplayerENet.new()
	peer.set_bind_ip("127.0.0.1")
	peer.create_server(server_info.port, server_info.max_players)
	get_tree().network_peer = peer
	
	emit_signal("server_start")
	
	print("Server listening on PORT: %s" % server_info.port)

func _stop():
	emit_signal("server_stop")

func join(ip, port):
	var peer = NetworkedMultiplayerENet.new()
	
	if (peer.create_client("168.235.71.12", 4464) != OK):
		print("Failed to create client")
		emit_signal("join_fail")
		
		return
	
	get_tree().network_peer = peer

func _player_connected(id):
	emit_signal("join_success")
	print("Connected %s" % id)
	
func _player_disconnected(id):
	emit_signal("join_fail")
	print("Disconnected %s" % id)
	
