extends CanvasLayer

var current_level = 3
var current_level_scene = null

func _ready():
	$Label.text = "Level %s"%current_level
	load_next_level()

func finished_level():
	current_level += 1
	$Label.text = "Level %s"%current_level
	$AnimationPlayer.play("fade to white")
	get_node("/root/UI/fader/AnimationPlayer").play("fade to clear")
	yield($AnimationPlayer, "animation_finished")
	load_next_level()
	
func restart_level():
	# add a game over screen with a button or smthg
	load_next_level()

func load_next_level():
	get_tree().change_scene("res://Levels/%s.tscn"%current_level)
	get_node("/root/LevelData").current_level = current_level
	get_node("/root/UI").loadData()
	$AnimationPlayer.play("fade to clear")
	get_node("/root/UI/fader/AnimationPlayer").play("fade to white")

func _input(event):
	if event.is_action_pressed("restart"):
		restart_level()
