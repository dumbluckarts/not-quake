extends Spatial

var id: int

func damage(amount, idk):
	Client.send_to(id, "update_from_client", { 'lol': 'u got shot!' })
