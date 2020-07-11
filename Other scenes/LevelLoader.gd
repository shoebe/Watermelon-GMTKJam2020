extends Control

var current_level = 1
var current_level_scene = null

func _ready():
	#$Layer/ColorRect.rect_size = get_viewport().size
	load_next_level()
	

func finished_level():
	current_level += 1
	$Layer/Label.text = "Level %s"%current_level
	$Layer/AnimationPlayer.play("fade to white")
	yield($Layer/AnimationPlayer, "animation_finished")
	load_next_level()
	
func load_next_level():
	get_tree().change_scene("res://Levels/%s.tscn"%current_level)
	$Layer/AnimationPlayer.play("fade to clear")
