extends Area2D

export var TILE_WIDTH = 24
export var AMOUNT_OF_FRAMES_PER_MOVEMENT = 8.0

var current_lerp_val = 0
var moving = false
var next_movement = null
var old_pos = null
var lerp_destination = Vector2.ZERO

var reached_goal = false

var move_count
var forced_moves

func _ready():
	var data = get_node("/root/LevelData").get_level_data()
	move_count = data["total_moves"]
	forced_moves = data["forced_moves"]

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
	if move_count <= 0 :
		# add a thing to the UI which makes you restart
		return
	decrement_counter()
	direction = possible_forced_direction(move_count, direction)
	old_pos = position
	lerp_destination = position + direction*self.TILE_WIDTH
	moving = true
	current_lerp_val = 0
	
func possible_forced_direction(moves_left, direction):
	if moves_left in forced_moves.keys():
		return forced_moves[moves_left]
	return direction
	
func decrement_counter():
	get_node("/root/UI").decrement_counter()
	move_count -= 1

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
		print(body.collision_layer)
		match body.collision_layer:
			2: # wall
				reversal_move()
				moving = false
				return true
			4: # water
				$AnimatedSprite.play("death")
			64: # goal
				if !reached_goal:
					get_node("../Goal/AnimationPlayer").play("eaten")
					get_node("/root/LevelLoader").finished_level()
					reached_goal = true
	
func _physics_process(delta):
	if moving:
		if collision_detection(): return
		moving = move()
		if !moving and next_movement != null:
			start_moving(next_movement)
			next_movement = null
			


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "death":
		get_node("/root/LevelLoader").restart_level()
