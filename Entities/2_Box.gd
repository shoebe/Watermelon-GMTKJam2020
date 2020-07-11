extends "res://Entities/abstracts/Moveable.gd"

func collision_detection():
	for body in get_overlapping_bodies():
		match body.collision_layer:
			2: # wall
				reversal_move()
				get_node("../Player").reversal_move()
				return true
			4: # water
				collision_layer = 32
				var tile_pos = body.world_to_map(lerp_destination)
				# maybe clear to another water tile
				body.set_cellv(tile_pos, -1)
				
func _physics_process(delta):
	if moving:
		if collision_detection(): return
		moving = move()

