extends Node

export var PORT: int = 4464
export var sIP: String = "LocalHost"
#onready var network = get_node("/root/Network")

# Called when the node enters the scene tree for the first time.
func _ready():
	Network.connect("join_success", self, "_on_ready_to_play")
	Network.connect("join_fail", self, "_on_join_fail")
	join()

func join():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(sIP, PORT)
	get_tree().network_peer = peer
	#Network.join_server(sIP, PORT)
	print("Connected to ")

func _on_ready_to_play():
	print("Ready to play!")

func _on_join_fail():
	print("Cant join game")
