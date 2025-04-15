extends Node2D

@export var _grid: Grid
@export var _pawn: Pawn
@onready var _grid_view: GridView = %GridView
@onready var _pawn_agent: PawnAgent = %PawnAgent

var _current_index: int = 0


func _ready() -> void:
	_grid.set_up()
	_grid_view.grid = _grid

func _move_pawn(step : int):
	var index : int = _current_index + step;

	var path: Array[int] = _grid.get_move_path(_current_index, index)
	_current_index = _grid.get_valid_index(index)

	var path_positions : Array[Vector2] = []
	for i in path:
		path_positions.append(_grid_view.get_cell_position(i))

	await _pawn_agent.move_path(path_positions)
	
	var gold: int = randi_range(-100,100)
	_pawn.gold += gold
	
	
	
	
