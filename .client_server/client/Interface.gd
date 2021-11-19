extends CanvasLayer

func _ready():
	Client.start({
		'name': 'nelly'
	})

func _on_Button_pressed():
	print('uwu')
