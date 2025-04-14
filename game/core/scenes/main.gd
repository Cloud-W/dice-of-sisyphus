extends Node2D

@export var _grid: Grid

@onready var _grid_view: GridView = %GridView
@onready var _pawn_agent: PawnAgent = %PawnAgent

var _current_index: int = 0


func _ready() -> void:
	_grid.set_up()
	_grid_view.grid = _grid

func _move_pawn(step : int):
	var index : int = _current_index + step;
	if index >= _grid.max_size:
		index = index - _grid.max_size
	_current_index = index
	var postion: Vector2         = _grid_view.get_cell_position(index)
	var target: Vector2 = _grid_view.to_global(postion)
	_pawn_agent.move_to(target)
	