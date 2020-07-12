extends "res://Entities/abstracts/Moveable.gd"

export var AMOUNT_OF_FRAMES_PER_MOVEMENT = 7.0
var caller = null
var next_movement = null

func push_block(dir, caller):
	if moving:
		return
	start_moving(dir)
	self.caller = caller

func collision_detection():
	for body in get_overlapping_bodies():
		match body.collision_layer:
			2: # wall
				reversal_move()
				return true
			4: # water
				collision_layer = 32
				var tile_pos = body.world_to_map(lerp_destination)
				# maybe clear to another water tile
				body.set_cellv(tile_pos, -1)
				
func reversal_move():
	.reversal_move()
	self.caller.reversal_move()

func _physics_process(delta):
	if moving:
		if collision_detection(): return
		moving = move(AMOUNT_OF_FRAMES_PER_MOVEMENT)
		if !moving and next_movement != null:
			start_moving(next_movement)
			next_movement = null

func _on_Box_area_entered(area):
	match area.collision_layer:
		8: #box
			area.push_block(self.direction, self)
		16: # arrows
			next_movement = area.get_direction()
			caller = null
