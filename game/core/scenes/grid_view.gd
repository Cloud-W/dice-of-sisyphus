class_name GridView
extends Node2D
@export var grid: Grid: set = _set_grid
@export var cell_view_prefab: PackedScene = preload("res://game/core/scenes/cell_view.tscn")
@export var cell_view_size: Vector2 = Vector2(50, 50)


func _set_grid(value: Grid) -> void:
	grid = value
	if not grid:
		return

	if not is_node_ready():
		await ready

	_update_grid()


func _update_grid() -> void:
	for cell: Cell in grid.cells:
		var cell_view: CellView = cell_view_prefab.instantiate()
		cell_view.position = _calcualte_position(cell)
		add_child(cell_view)


func _calcualte_position(cell: Cell) -> Vector2:
	var pos : Vector2 = grid.positions_config[cell.index] * cell_view_size.x;
	#return Vector2(cell.index * cell_view_size.x, 0)
	return pos


func get_cell_position(index: int) -> Vector2:
	return to_global(_calcualte_position(grid.cells[index]))
