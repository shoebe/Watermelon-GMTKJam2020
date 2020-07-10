extends Area2D

var curent_lerp_val = 0
var moving = false
var lerp_destination = Vector2.ZERO

func _input(event):
	if event.is_action_pressed("ui_right"):
		lerp_destination = position + Vector2.RIGHT
		move(position + Vector2.RIGHT)
	if event.is_action_pressed("ui_left"):
		lerp_destination = position + Vector2.LEFT
		move(position + Vector2.LEFT)
	if event.is_action_pressed("ui_up"):
		lerp_destination = position + Vector2.UP
		move(position + Vector2.UP)
	if event.is_action_pressed("ui_down"):
		lerp_destination = position + Vector2.DOWN
		move(position + Vector2.DOWN)
		
		
func move(direction:Vector2):
	
	
func _physics_process(delta):
	if moving:
		moving = move(cur_moving_dir)
