extends CanvasLayer

func _ready():
	Server.connect("server_start", self, "_on_ready_to_play")
	Server.connect("join_success", self, "_on_ready_to_play")
	Server.connect("join_fail", self, "_on_join_fail")
	get_tree().connect("connection_failed", self, "_on_join_fail")
	Server._start()

func _on_btCreate_pressed():
	if(!$PanelHost/txtServerName.text.empty()):
		Server.server_info.name = $PanelHost/txtServerName
	Server.server_info.max_players = int($PanelHost/txtMaxPlayers.value)
	Server.server_info.port = int($PanelHost/txtPort.text)
	
	Server._start()

func _on_ready_to_play():
	get_tree().change_scene("res://Main.tscn")

func _on_join_fail():
	print("Failed to join server")


func _on_btJoin_pressed():
#	var port = int($PanelJoin/txtPort.text)
#	var ip = $PanelJoin/txtIP.text
#	Server.join(ip, port)
	var peer = NetworkedMultiplayerENet.new()
	
	if (peer.create_client("168.235.71.12", 4464) != OK):
		print("Failed to create client")
		emit_signal("join_fail")
		
		return
	
	get_tree().network_peer = peer
