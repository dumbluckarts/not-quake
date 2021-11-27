extends KinematicBody
class_name Player

signal died

export(PackedScene) var BULLET
export(int) var HEALTH

onready var orig = $Mouse/Camera/Gun.rotation_degrees.y
onready var enabled = true
var spawned = false
var alive = true

var inventory_open = false

func _process(_delta):
	if not spawned:
		_spawn('')
	if Input.is_action_just_pressed("restart"):# and $CanvasLayer/Label.visible:
		enabled = true
		HEALTH = 10
		_spawn('')
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
	if not enabled or inventory_open: return
	if event is InputEventMouseMotion:
		$Mouse.process($Mouse/Camera, event.relative)

func _spawn(location):
	spawned = true
	alive = true
	if not location == '':
		global_transform.origin = Vector3(0,0,0)
		return
	
	var map_script = $"../Map".get_child(0)
	
	if not map_script.has_method("get_spawn"):	return
	
	var sp = map_script.get_spawn()
	
	global_transform.origin = sp
	var cam_y = $Mouse/Camera.global_transform.origin.y
	var lookat = Vector3.ZERO + Vector3(0,cam_y,0) # offset so you are always looking "ahead" towards the map origin
	$Mouse/Camera.look_at(lookat, Vector3.UP)

func damage(amount: int):
	HEALTH -= amount
	$Movement.HITPUNCH_SCALAR = 0.6
	$Combat.hitpunch()
	if HEALTH <= 0:
		die()
		
	else:
		$CanvasLayer/Panel.visible = true
		yield(get_tree().create_timer(0.1), "timeout")
		$CanvasLayer/Panel.visible = false
		

func die():
	emit_signal("died")
	enabled = false
	alive = false
	$CanvasLayer/Panel.visible = true
	$CanvasLayer/Label.visible = true
