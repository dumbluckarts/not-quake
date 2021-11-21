extends KinematicBody
class_name Player

export(PackedScene) var BULLET

onready var orig = $Mouse/Camera/Gun.rotation_degrees.y

func _process(_delta):
	if $Movement.is_jumping():
		$Audio/AnimationPlayer.play("jump")
		$Movement/AnimationPlayer.play("jump")
	elif $Movement.is_falling():
		$Audio/AnimationPlayer.play("fall")
		$Movement/AnimationPlayer.play("fall")
	elif $Movement.is_moving():
		$Audio/AnimationPlayer.play("walk")
		$Movement/AnimationPlayer.play("walk")
		$Audio/AudioStreamPlayer3D_Steps.pitch_scale = rand_range(0.8, 1.2)
	else:
		$Audio/AnimationPlayer.play("default")
		$Movement/AnimationPlayer.play("default")

func _physics_process(delta):
	$Movement.process(self, delta, $Mouse/Camera.global_transform.basis)
	
func _input(event):
	if event is InputEventMouseMotion:
		$Mouse.process($Mouse/Camera, event.relative)
	
