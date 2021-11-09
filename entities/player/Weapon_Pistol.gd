extends Spatial

const DAMAGE = 1

var is_weapon_enabled = true

var player_node = null


func _ready():
	pass

func shoot():
	var ray = $RayCast
	ray.force_raycast_update()
	
	if ray.is_colliding():
		var body = ray.get_collider()
		
		if body == player_node:
			# dont kill yo self!
			pass
		elif body.has_method("bullet_hit"):
			body.bullet_hit(DAMAGE, ray.global_transform)
