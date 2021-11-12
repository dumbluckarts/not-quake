extends CanvasLayer

export var HITMARKER: PackedScene


func _on_Combat_hit_damagable():
	var hitmarker = HITMARKER.instance()
	hitmarker.rotation_degrees = rand_range(-60, 60)
	$Crosshair.add_child(hitmarker)
