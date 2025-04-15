class_name Grid
extends Resource

var max_size: int:
	get:
		return cells_config.size()

@export var positions_config: Array[Vector2i]
@export var cells_config: Array[Cell]

var cells: Array[Cell] = []


func set_up() ->void:
	cells.resize(max_size)
	for index in range(max_size):
		var temlpate_cell: Cell = cells_config[index]
		var cell: Cell          = temlpate_cell.duplicate()
		cell.index = index
		cells[index] = cell


func get_move_path(curr: int, target: int) -> Array[int]:
	var path: Array[int] = []
	for n in range(curr + 1, target + 1):
		var index: int = get_valid_index(n)
		path.append(index)
	return path


func get_valid_index(index: int) -> int:
	if index >= max_size:
		index = index - max_size
	return index

	 
	


