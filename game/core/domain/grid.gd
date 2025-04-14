class_name Grid
extends Resource

@export var max_size: int = 8

var cells: Array[Cell] = []


func set_up() ->void:
	cells.resize(max_size)
	for index in range(max_size):
		var cell := Cell.new()
		cell.index = index
		cells[index] = cell
		
		 
	


