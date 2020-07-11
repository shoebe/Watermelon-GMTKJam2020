extends TextureRect


func set_dir(direction:Vector2):
	match direction:
		Vector2.UP:
			texture.region = Rect2(0,0,24,24)
		Vector2.DOWN:
			texture.region = Rect2(24,0,24,24)
		Vector2.RIGHT:
			texture.region = Rect2(0,24,24,24)
		Vector2.LEFT:
			texture.region = Rect2(24,24,24,24)
			
