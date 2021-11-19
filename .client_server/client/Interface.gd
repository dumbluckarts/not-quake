extends CanvasLayer

func _on_Button_pressed():
	Client.send($TextEdit.text)
