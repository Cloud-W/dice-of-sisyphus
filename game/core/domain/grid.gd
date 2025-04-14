class_name Grid
extends Resource

@export var max_size: int = 8
@export var positions_config : Array[Vector2i]

var cells: Array[Cell] = []


func set_up() ->void:
	cells.resize(max_size)
	for index in range(max_size):
		var cell := Cell.new()
		cell.index = index
		cells[index] = cell

func get_move_path(curr : int, target : int) -> Array[int]:
	var path : Array[int] = []
	for n in range(curr + 1, target + 1):
		var index : int = get_valid_index(n)
		path.append(index)
	return path

func get_valid_index(index : int) -> int:
	if index >= max_size:
		index = index - max_size
	return index

	 
	


