extends CanvasLayer

func _ready():
	$fader/AnimationPlayer.play("fade to white")

func _on_Button_pressed():
	get_node("/root/LevelLoader").current_level = 0
	get_node("/root/LevelLoader").finished_level()
	call_deferred("free")
