extends Spatial

export var nameplate_enabled = 0

var player_name = ""
onready var nameplate = $NameplateAnchor/Nameplate

func _ready():
	if nameplate_enabled:
		nameplate.set_text(player_name)

func damage(amount, idk):
	Client.send_to(name, { 'damage': 1 })
