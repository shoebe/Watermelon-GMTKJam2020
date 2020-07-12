extends Node

var current_level = 1

var levelData = [
	{ #level 1
		"forced_moves": {2: Vector2.DOWN},
		"total_moves": 12
	},
	{ #level 2
		"forced_moves": {6: Vector2.RIGHT},
		"total_moves": 9
	},
	{ #level 3
		"forced_moves": {3: Vector2.UP, 10: Vector2.DOWN},
		"total_moves": 13
	},
	{ #level 4
		"forced_moves": {12: Vector2.UP, 15: Vector2.DOWN, 17: Vector2.LEFT},
		"total_moves": 18
	},
	{ #level 5
		"forced_moves": {6: Vector2.RIGHT, 10: Vector2.RIGHT, 12: Vector2.RIGHT, 16: Vector2.UP, 17: Vector2.UP, 18: Vector2.RIGHT, 19: Vector2.RIGHT},
		"total_moves": 23
	},
	{ #level 6
		"forced_moves": {7: Vector2.LEFT, 8: Vector2.LEFT, 10: Vector2.UP, 18: Vector2.RIGHT, 19: Vector2.DOWN, 31: Vector2.RIGHT, 47: Vector2.DOWN, 49: Vector2.LEFT},
		"total_moves": 55
	}]
	
func get_level_data(): 
	if current_level <= levelData.size():
		return levelData[current_level - 1]
	else:
		return {
		"forced_moves": {},
		"total_moves": 99
	}
