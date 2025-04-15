extends Node2D

signal move_pawn_completed
signal roll_requested
@export var _grid: Grid
@export var _pawn: Pawn
@export var _is_auto_roll : bool


@onready var _grid_view: GridView = %GridView
@onready var _pawn_agent: PawnAgent = %PawnAgent

var _current_index: int = 0


func _ready() -> void:
	_grid.set_up()
	_grid_view.grid = _grid


func _move_pawn(step: int):
	_exit_current_cell()

	var index: int = _current_index + step;

	var path: Array[int] = _grid.get_move_path(_current_index, index)
	_current_index = _grid.get_valid_index(index)

	var path_positions: Array[Vector2] = []
	for i in path:
		path_positions.append(_grid_view.get_cell_position(i))

	await _pawn_agent.move_path(path_positions)

	_enter_current_cell()
	move_pawn_completed.emit()
	
	if _is_auto_roll: 
		roll_requested.emit()


func _enter_current_cell():
	var cell: Cell = _grid.cells[_current_index]
	cell.enter(_pawn)


func _exit_current_cell():
	var cell: Cell = _grid.cells[_current_index]
	cell.exit(_pawn)
	
