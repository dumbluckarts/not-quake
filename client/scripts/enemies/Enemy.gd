extends Spatial

func damage(amount, idk):
	Client.send_to(name, { 'damage': 1 })
