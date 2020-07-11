extends CanvasLayer

var move_count
var max_move_count

func loadData():
	var levelData = get_node("/root/LevelData").get_level_data()
	max_move_count = levelData["total_moves"]
	move_count = 0
	create_arrows()
	decrement_counter()

func create_arrows():
	pass

func decrement_counter():
	$Label.text = String(max_move_count - move_count)
	move_count += 1
