extends "res://Entities/abstracts/Moveable.gd"

var change_layer_in_number_frames = 0 

func collision_detection():
	for body in get_overlapping_bodies():
		match body.collision_layer:
			2: # wall
				reversal_move()
				get_node("../Player").reversal_move()
				change_layer_in_number_frames = 10 
				moving = false
				return true
				
func _physics_process(delta):
	if change_layer_in_number_frames > 0:
		change_layer_in_number_frames -= 1
	else:
		collision_layer = 8
	if moving:
		if collision_detection(): return
		moving = move()

