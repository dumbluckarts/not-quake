extends Node

export var PORT: int = 4464
export var sIP: String = "LocalHost"

# Called when the node enters the scene tree for the first time.
func _ready():
	Network.connect("join_success", self, "_on_ready_to_play")
	Network.connect("join_fail", self, "_on_join_fail")
	join()

func join():
	Network.join_server(sIP, PORT)
	print("Connected to ")

func _on_ready_to_play():
	print("Ready to play!")
