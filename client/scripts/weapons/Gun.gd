extends Spatial

export var DAMAGE = 1
export var ITEM = false

func _process(delta):
	if ITEM:
		$MeshInstance/Outline.visible = true
		scale = Vector3(2, 2, 2)
		$AnimationPlayer.play("item")
	else:
		$MeshInstance/Outline.visible = false
		scale = Vector3(1, 1, 1)
		$AnimationPlayer.stop()

func is_on_screen():
	return $VisibilityNotifier.is_on_screen()
