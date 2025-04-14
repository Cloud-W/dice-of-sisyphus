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
		
		 
	


