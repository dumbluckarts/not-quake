extends Node

export var PORT: int = 4464
export var sIP: String = "LocalHost"

func _ready():
	Server.connect("join_success", self, "_on_join_success")
	Server.connect("join_fail", self, "_on_join_fail")
	join()

func join():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(sIP, PORT)
	get_tree().network_peer = peer


func _on__on_join_success():
	print("Ready to play!")

func _on_join_fail():
	print("Cant join game")
