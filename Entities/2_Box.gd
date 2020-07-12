extends "res://Entities/abstracts/Moveable.gd"

export var AMOUNT_OF_FRAMES_PER_MOVEMENT = 7.0
var caller = null
var next_movement = null

var counter
var forced_moves

func _ready():
	counter = 0
	var data = get_node("/root/LevelData").get_level_data()
	if "box_moves" in data.keys():
		forced_moves = data["box_moves"]
	else:
		forced_moves = {}

func push_block(dir, caller):
	if moving:
		if caller.get_type() == "box":
			if caller.caller == null or caller.caller.get_type() == "box":
				return
		if direction == -dir:
			caller.reversal_move()
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
	if self.caller != null:
		self.caller.reversal_move()

func _physics_process(delta):
	if moving:
		if collision_detection(): return
		moving = move(AMOUNT_OF_FRAMES_PER_MOVEMENT)
		if !moving:
			self.caller = null
			if next_movement != null:
				start_moving(next_movement)
				next_movement = null

func get_type():
	return "box"

func _on_Box_area_entered(area):
	match area.collision_layer:
		8: #box
			area.push_block(self.direction, self)
		16: # arrows
			next_movement = area.get_direction()
			caller = null
			

func _on_Player_moved():
	counter += 1
	if counter in forced_moves.keys():
		start_moving(forced_moves[counter])
