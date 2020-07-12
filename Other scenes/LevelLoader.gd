extends CanvasLayer

var current_level = 1
var last_level = 9
var current_level_scene = null
const game_finished_scene = preload("res://Other scenes/CompletedGame.tscn")
var game_finished_loaded = false

func _ready():
	$Label.text = "Level %s"%current_level
	load_next_level()

func finished_level():
	current_level += 1
	if current_level > last_level:
		if game_finished_loaded:
			return
		var thing = game_finished_scene.instance()
		add_child(thing)
		game_finished_loaded = true
		yield(thing, "button_pressed")
		thing.call_deferred("free")
		current_level = 0
		finished_level()
		return
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
	if event.is_action_pressed("next_level"):
		finished_level()
	if event.is_action_pressed("previous_level"):
		current_level = clamp(current_level - 2, 0, 99)
		finished_level()
