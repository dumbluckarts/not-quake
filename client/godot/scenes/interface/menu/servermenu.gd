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
