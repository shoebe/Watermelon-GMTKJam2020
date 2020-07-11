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
				var tile_id = body.get_cellv(tile_pos)
				body.tile_set.remove_tile(tile_id)
				
func _physics_process(delta):
	if moving:
		if collision_detection(): return
		moving = move()

