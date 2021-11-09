extends Label

##################################################

export var enabled := true

##################################################

func _physics_process(_delta: float) -> void:
	if enabled:
		var v: Vector3 = $"../..".velocity
		var s = v.length()/_delta
		if v == null:
			text = "x: 0 y: 0 z: 0 speed: 0"
			return
		
		text = "x: " + str(stepify(v.x, 0.01)) + " y: " + str(stepify(v.y, 0.01)) + " z: " + str(stepify(v.z, 0.01)) + " speed: " + str(stepify(s,0.01))
		
	
	else:
		text = ""
