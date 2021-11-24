extends KinematicBody
class_name Player

export(PackedScene) var BULLET
export(int) var HEALTH

onready var orig = $Mouse/Camera/Gun.rotation_degrees.y
onready var enabled = true

func _process(_delta):
	if Input.is_action_just_pressed("restart") and $CanvasLayer/Label.visible:
		enabled = true
		HEALTH = 10
		$CanvasLayer/Panel.visible = false
		$CanvasLayer/Label.visible = false
	if not enabled: return
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
	if not enabled: return
	$Movement.process(self, delta, $Mouse/Camera.global_transform.basis)
	
func _input(event):
	if not enabled: return
	if event is InputEventMouseMotion:
		$Mouse.process($Mouse/Camera, event.relative)
	
func damage(amount: int):
	HEALTH -= amount
	$Movement.HITPUNCH_SCALAR = 0.6
	$Combat.hitpunch()
	if HEALTH <= 0:
		enabled = false
		$CanvasLayer/Panel.visible = true
		$CanvasLayer/Label.visible = true
	else:
		$CanvasLayer/Panel.visible = true
		yield(get_tree().create_timer(0.1), "timeout")
		$CanvasLayer/Panel.visible = false
