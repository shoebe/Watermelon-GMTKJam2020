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
	}] 
	
func get_level_data(): 
	if current_level <= levelData.size():
		return levelData[current_level - 1]
	else:
		return {
		"forced_moves": {},
		"total_moves": 99
	}
