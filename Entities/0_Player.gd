extends Area2D

var TILE_WIDTH = 24

var AMOUNT_OF_FRAMES_PER_MOVEMENT = 10.0
var current_lerp_val = 0
var moving = false
var next_movement = null
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
	lerp_destination = position + direction*self.TILE_WIDTH
	moving = true
	current_lerp_val = 0
	move()

func move():
	current_lerp_val = clamp(current_lerp_val+1/AMOUNT_OF_FRAMES_PER_MOVEMENT, 0, 1)
	position = position.linear_interpolate(lerp_destination, current_lerp_val)
	if current_lerp_val == 1:
		return false
	return true
	
	
func _physics_process(delta):
	if moving:
		moving = move()
		if !moving and next_movement != null:
			start_moving(next_movement)
			next_movement = null
			
