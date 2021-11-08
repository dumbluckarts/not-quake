extends KinematicBody

var velocity = Vector2()

func _physics_process(delta):
	var input = Vector3(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		0,
		0
	)	
	
	#print(input)
	
	$Mouse.move($Camera, delta)

func _input(event):
	if event is InputEventMouseMotion:
		$Mouse.delta(event.relative)
