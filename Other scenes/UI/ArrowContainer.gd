extends Container

export var CELL_SIZE = Vector2(192,96)
export var LERP_FRAME_COUNT = 10
var animating = false
var originalPositions = null
var destinationPositions = null
var lerpval = 0


func _notification(what):
	if (what==NOTIFICATION_SORT_CHILDREN):
		animating = true
		originalPositions = []
		destinationPositions = []
		lerpval = 0
		var cur_pos = Vector2.ZERO
		for c in get_children():
			originalPositions.append(c.position)
			destinationPositions.append(cur_pos)
			cur_pos.y += CELL_SIZE.y

func set_some_setting():
	# Some setting changed, ask for children re-sort
	queue_sort()
	
func _process(delta):
	if animating:
		for c in get_children():
			fit_child_in_rect( c, Rect2(Vector2(), CELL_SIZE))
