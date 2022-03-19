extends Area

export var impulse = Vector3(0,0,0)

func _on_Area_body_entered(body):
	if body.is_in_group("physicable"):
		if body.has_method("apply_central_impulse"):
			body.apply_central_impulse(impulse)
		elif body.get_node("Movement").has_method("set_impulse"):
			body.get_node("Movement").set_impulse(impulse)


func _on_Area_body_exited(body):
	if body.is_in_group("physicable"):
		if not body.has_node("Movement"): return
		if body.get_node("Movement").has_method("set_impulse"):
			body.get_node("Movement").set_impulse(Vector3.ZERO)
