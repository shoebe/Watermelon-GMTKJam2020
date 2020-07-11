extends Node

var current_level = 1

var levelData = [
	{ #level 1
		"forced_moves": {8: Vector2.RIGHT, 4: Vector2.DOWN},
		"total_moves": 10
	},
	{ #level 2
		"forced_moves": {},
		"total_moves": 99
	}
]

func get_level_data():
	return levelData[current_level - 1]
