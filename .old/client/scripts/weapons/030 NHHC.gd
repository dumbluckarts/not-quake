extends Spatial

export(Resource) var STREAM

var cooldown = false

func shoot():
	if cooldown: return
	$AnimationPlayer.play("shoot")
	var audio = AudioStreamPlayer.new()
	add_child(audio)
	audio.bus = "Guns"
	audio.stream = STREAM
	audio.connect("finished", audio, "queue_free")
	audio.pitch_scale = rand_range(1.0, 1.1)
	audio.play()
	cooldown = true
	yield(get_tree().create_timer(0.12), "timeout")
	$AnimationPlayer.play("RESET")
	cooldown = false
