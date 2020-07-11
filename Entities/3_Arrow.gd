extends Area2D


func get_direction():
	match stepify(rotation_degrees, 1):
		0.0:
			return Vector2.UP
		90.0:
			return Vector2.RIGHT
		180.0:
			return Vector2.DOWN
		270.0:
			return Vector2.LEFT
		
