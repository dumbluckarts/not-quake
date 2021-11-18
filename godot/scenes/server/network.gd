extends Node

signal server_created
signal join_success
signal join_fail

var server_info = {
	name = "Server",      # Holds the name of the server
	max_players = 0,      # Maximum allowed connections
	used_port = 0         # Listening port
}

var players = {}

func _ready():
	pass
	#get_tree().connect("network_peer_connected", self, "_on_player_connected")
	#get_tree().connect("network_peer_disconnected", self, "_on_player_disconnected")
	#get_tree().connect("connected_to_server", self, "_on_connected_to_server")
	#get_tree().connect("connection_failed", self, "_on_connection_failed")
	#get_tree().connect("server_disconnected", self, "_on_disconnected_from_server")
	
"""
func create_server():
	var net = NetworkedMultiplayerENet.new()
	
	if (net.create_server(server_info.used_port, server_info.max_players) != OK):
		print("Failed to create server")
		return
	
	get_tree().set_network_peer(net)
	
	emit_signal("server_created")

func join_server(ip, port):
	var net = NetworkedMultiplayerENet.new()
	
	if (net.create_client(ip, port)!= OK):
		print("Failed to create client")
		emit_signal("join_fail")
		return
	get_tree().set_network_peer(net)
	emit_signal("join_success")

# Everyone gets notified whenever a new client joins the server
func _on_player_connected(id):
	#print("Connected %s" % id)
	pass


# Everyone gets notified whenever someone disconnects from the server
func _on_player_disconnected(id):
	pass


# Peer trying to connect to server is notified on success
func _on_connected_to_server():
	
	emit_signal("join_success")


# Peer trying to connect to server is notified on failure
func _on_connection_failed():
	emit_signal("join_fail")
	get_tree().set_network_peer(null)


# Peer is notified when disconnected from server
func _on_disconnected_from_server():
	pass
"""
