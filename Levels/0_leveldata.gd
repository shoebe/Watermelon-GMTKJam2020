extends Node

var current_level = 1

var levelData = [
	{ #level 1
		"forced_moves": {2: Vector2.RIGHT, 6: Vector2.DOWN},
		"total_moves": 8
	},
	{ #level 2
		"forced_moves": {},
		"total_moves": 99
	}
]

func get_level_data():
	if current_level <= levelData.size():
		return levelData[current_level - 1]
	else:
		return {
		"forced_moves": {},
		"total_moves": 99
	}
