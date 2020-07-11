extends TextureRect

var count

func set_dir(direction:Vector2):
	$Arrow.texture = $Arrow.texture.duplicate()
	match direction:
		Vector2.UP:
			$Arrow.texture.region = Rect2(0,0,24,24)
		Vector2.DOWN:
			$Arrow.texture.region = Rect2(24,0,24,24)
		Vector2.RIGHT:
			$Arrow.texture.region = Rect2(0,24,24,24)
		Vector2.LEFT:
			$Arrow.texture.region = Rect2(24,24,24,24)
			
func update_text():
	$Label.text = String(count)
