extends Control


func set_dir(direction:Vector2):
	match direction:
		Vector2.UP:
			$Sprite.frame = 0
		Vector2.DOWN:
			$Sprite.frame = 1
		Vector2.RIGHT:
			$Sprite.frame = 2
		Vector2.LEFT:
			$Sprite.frame = 3
			
