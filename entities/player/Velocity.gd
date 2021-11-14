extends Label

export var enabled := true

func _physics_process(_delta: float) -> void:
	var p = $"../../Player"
	var v = p.get_node("Movement").get_v()
	var x = stepify(p.global_transform.origin.x, 0.1)
	var y = stepify(p.global_transform.origin.y, 0.1)
	var z = stepify(p.global_transform.origin.z, 0.1)
	var s = stepify(v.length()/(_delta*60), 0.1)
	#text = "x: %s y: %s z: %s s: %s" % [str(x), str(y), str(z), str(s)]
	text = "v: %s" % str(s)
