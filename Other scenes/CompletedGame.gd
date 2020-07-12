extends CanvasLayer

signal button_pressed

func _ready():
	$fader/AnimationPlayer.play("fade to white")

func _on_Button_pressed():
	emit_signal("button_pressed")
