extends CanvasLayer

var move_count
var max_move_count

func loadData():
	free_grid()
	var levelData = get_node("/root/LevelData").get_level_data()
	max_move_count = levelData["total_moves"]
	move_count = 0
	var forced_moves = levelData["forced_moves"]
	create_arrows(forced_moves)
	decrement_counter()

func free_grid():
	for child in $ArrowContainer.get_children():
		child.free()

func create_arrows(forced_moves):
	var node = $ArrowContainer
	for key in forced_moves.keys():
		var grid_item = load("res://Other scenes/UI/Arrow.tscn")
		var child = grid_item.instance()
		node.add_child(child)
		child.set_dir(forced_moves[key])
		child.count = key+1
		child.update_text()
		

func decrement_counter():
	$Label.text = "Moves left: %s"%(max_move_count - move_count)
	var node = $ArrowContainer
	for child in node.get_children():
		child.count -= 1
		child.update_text()
		if child.count <= 0:
			child.free()
	move_count += 1
