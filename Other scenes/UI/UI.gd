extends CanvasLayer

var move_count
var max_move_count

func loadData():
	var levelData = get_node("/root/LevelData").get_level_data()
	max_move_count = levelData["total_moves"]
	move_count = 0
	var forced_moves = levelData["forced_moves"]
	create_arrows(forced_moves)
	decrement_counter()

func create_arrows(forced_moves):
	var node = $column
	var class_ = ResourceLoader.load("res://Other scenes/UI/Arrow&Label.tscn")
	for key in forced_moves.keys():
		var child = class_.instance


func decrement_counter():
	$Label.text = String(max_move_count - move_count)
	move_count += 1
