extends CanvasLayer

var move_count
var max_move_count
const grid_item = preload("res://Other scenes/UI/Arrow.tscn")

func loadData():
	free_grid()
	var levelData = get_node("/root/LevelData").get_level_data()
	max_move_count = levelData["total_moves"]
	move_count = 0
	var forced_moves = levelData["forced_moves"]
	var box_moves
	if "box_moves" in levelData.keys():
		box_moves = levelData["box_moves"]
	else:
		box_moves = {}
	create_arrows(forced_moves, box_moves)
	decrement_counter()

func free_grid():
	for child in $ArrowContainer.get_children():
		child.free()
	for child in $BoxArrowContainer.get_children():
		child.free()

func create_arrows(forced_moves, box_moves):
	var node = $ArrowContainer
	$ContainerTitle.visible = true
	for key in forced_moves.keys():
		var child = grid_item.instance()
		node.add_child(child)
		child.set_dir(forced_moves[key])
		child.count = key
		child.update_text()
	
	$ContainerTitle2.visible = true
	node = $BoxArrowContainer
	for key in box_moves.keys():
		var child = grid_item.instance()
		node.add_child(child)
		child.set_dir(box_moves[key])
		child.count = key
		child.update_text()
		

func decrement_counter():
	$Label.text = "%s"%(max_move_count - move_count)
	var node = $ArrowContainer
	for child in node.get_children():
		child.count -= 1
		child.update_text()
		if child.count < 0:
			child.free()
	if node.get_child_count() == 0:
		$ContainerTitle.visible = false
		
	node = $BoxArrowContainer
	for child in node.get_children():
		child.count -= 1
		child.update_text()
		if child.count < 0:
			child.free()
	if node.get_child_count() == 0:
		$ContainerTitle2.visible = false
	move_count += 1
