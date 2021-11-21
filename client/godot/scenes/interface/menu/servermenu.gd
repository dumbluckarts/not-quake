extends CanvasLayer

func _on_btJoin_pressed():
	Client.connect("connection_established", self, "_start")
	Client.address = $PanelJoin/txtIP.text
	Client.port = int($PanelJoin/txtPort.text)
	Client.start({
		'name': $PanelPlayer/txtPlayerName.text,
		'color': $PanelPlayer/btColor.color
	})

func _start():
	get_tree().change_scene("res://Main.tscn")

func _process(delta):
	if Client._connecting: 
		$PanelJoin/btJoin.disabled = true
		$PanelJoin/btJoin.text = "Connecting..."
	else:
		$PanelJoin/btJoin.disabled = false
		$PanelJoin/btJoin.text = "Join"
