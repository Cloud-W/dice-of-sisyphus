extends Node2D

@export var _grid: Grid

@onready var _grid_view: GridView = %GridView
@onready var _pawn_agent: PawnAgent = %PawnAgent

var _current_index: int


func _ready() -> void:
	_grid.set_up()
	_grid_view.grid = _grid

	_test()


func _test():
	var postion: Vector2         = _grid_view.get_cell_position(1)
	var target: Vector2 = _grid_view.to_global(postion)
	_pawn_agent.move_to(target)
	