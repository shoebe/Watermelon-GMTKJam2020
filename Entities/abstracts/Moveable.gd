extends Area2D

export var TILE_WIDTH = 24

var current_lerp_val = 0
var moving = false
var old_pos = null
onready var lerp_destination = position
var direction

func start_moving(direction:Vector2):
	self.direction = direction
	old_pos = position
	lerp_destination += direction*self.TILE_WIDTH
	moving = true
	current_lerp_val = 0

func move(speed):
	current_lerp_val = clamp(current_lerp_val+1/speed, 0, 1)
	position = old_pos.cubic_interpolate(lerp_destination, 
	old_pos.linear_interpolate(lerp_destination, 0.2),
	old_pos.linear_interpolate(lerp_destination, 0.8),
	current_lerp_val)
	if current_lerp_val == 1:
		return false
	return true
	
func reversal_move():
	#maybe enhance
	position = old_pos
	lerp_destination = old_pos
	moving = false
	
func collision_detection():
	for body in get_overlapping_bodies():
		match body.collision_layer:
			2: # wall
				reversal_move()
				moving = false
				return true
