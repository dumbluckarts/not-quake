extends CanvasLayer
class_name Interface

export var HITMARKER: PackedScene

func _ready():
	$Crosshair.update()

func _on_Combat_hit_damagable():
	var hitmarker = HITMARKER.instance()
	hitmarker.rotation_degrees = rand_range(-60, 60)
	$Crosshair.add_child(hitmarker)

func _on_Crosshair_draw():
	$Crosshair.draw_circle(Vector2.ZERO, 1, Color.green)
