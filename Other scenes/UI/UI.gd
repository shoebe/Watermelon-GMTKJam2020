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
	var node = $grid
	var class_ = ResourceLoader.load("res://Other scenes/UI/Arrow.tscn")
	for key in forced_moves.keys():
		var child = class_.instance()
		node.add_child(child)
		child.set_dir(forced_moves[key])


func decrement_counter():
	$Label.text = String(max_move_count - move_count)
	move_count += 1
