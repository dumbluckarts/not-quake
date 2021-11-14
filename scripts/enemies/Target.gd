extends StaticBody

export var HEALTH = 1

var timer = Timer.new()

func _ready():
	timer.autostart = true
	timer.wait_time = 1.0
	timer.connect("timeout", self, "queue_free")
	add_child(timer)
	
	$AudioStreamPlayer.connect("finished", self, "queue_free")

func damage(damage, transform = null):
	HEALTH -= damage
	
	if HEALTH <= 0 and visible: 
		visible = false
		$AudioStreamPlayer.play()
