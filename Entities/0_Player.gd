extends Area2D

signal reached_goal

export var TILE_WIDTH = 24
export var AMOUNT_OF_FRAMES_PER_MOVEMENT = 8.0

var current_lerp_val = 0
var moving = false
var next_movement = null
var old_pos = null
var lerp_destination = Vector2.ZERO

func _input(event):
	if !moving:
		if event.is_action_pressed("ui_right"):
			start_moving(Vector2.RIGHT)
		if event.is_action_pressed("ui_left"):
			start_moving(Vector2.LEFT)
		if event.is_action_pressed("ui_up"):
			start_moving(Vector2.UP)
		if event.is_action_pressed("ui_down"):
			start_moving(Vector2.DOWN)
	else:
		if event.is_action_pressed("ui_right"):
			next_movement = Vector2.RIGHT
		if event.is_action_pressed("ui_left"):
			next_movement = Vector2.LEFT
		if event.is_action_pressed("ui_up"):
			next_movement = Vector2.UP
		if event.is_action_pressed("ui_down"):
			next_movement = Vector2.DOWN
		
		
func start_moving(direction:Vector2):
	old_pos = position
	lerp_destination = position + direction*self.TILE_WIDTH
	moving = true
	current_lerp_val = 0
	
func decrement_counter():
	get_parent().moves_left_counter -= 1
	return get_parent().moves_left_counter

func move():
	current_lerp_val = clamp(current_lerp_val+1/AMOUNT_OF_FRAMES_PER_MOVEMENT, 0, 1)
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

	
func collision_detection():
	for body in get_overlapping_bodies():
		if body.collision_layer == 2: # wall
			reversal_move()
			moving = false
			return true
		if body.collision_layer == 7: # goal
			get_parent().get_node("Goal/AnimationPlayer").play("eaten")
			emit_signal("reached_goal")
			
	
func _physics_process(delta):
	if moving:
		if collision_detection(): return
		moving = move()
		if !moving and next_movement != null:
			start_moving(next_movement)
			next_movement = null
			
