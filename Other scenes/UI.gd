extends CanvasLayer

func loadData():
	var levelData = get_node("/root/LevelData").get_level_data()
	$Label.text = String(levelData["total_moves"])

func decrement_counter():
	$Label.text = String(int($Label.text) - 1)
