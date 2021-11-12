extends CanvasLayer

export var HITMARKER: PackedScene

func _ready():
	$Crosshair.update()

func _on_Combat_hit_damagable():
	var hitmarker = HITMARKER.instance()
	hitmarker.rotation_degrees = rand_range(-60, 60)
	$Crosshair.add_child(hitmarker)

func _on_Crosshair_draw():
	var middle = get_viewport().get_visible_rect().size / 2
	var points = [
		Vector2(-8, 0),
		Vector2(8, 0),
		Vector2(0, -8), 
		Vector2(0, 8)
	]
	$Crosshair.draw_multiline(points, Color.green, 2, true)
