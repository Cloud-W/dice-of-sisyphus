extends Node2D

signal move_pawn_completed(pawn: Pawn)
#signal roll_requested(result: int)
@export var _grid: Grid
@export var _pawn: Pawn
@export var _is_auto_roll: bool

@onready var _grid_view: GridView = %GridView
@onready var _pawn_agent: PawnAgent = %PawnAgent
@onready var _diceView: DiceView = %DiceView

var _current_index: int = 0


func _ready() -> void:
	_grid.set_up()
	_grid_view.grid = _grid
	_pawn_agent.move_to(_grid_view.get_cell_position(0))
	_diceView.global_position = _grid_view.get_grid_center()


func start_roll() -> void:
	_roll_dice()


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
	move_pawn_completed.emit(_pawn)

	if _is_auto_roll and _pawn.status != Pawn.Status.BROKE:
		_roll_dice()


func _roll_dice() -> void:
	var result: int = _pawn.roll_dice()
	_diceView.roll(result)


func _enter_current_cell():
	var cell: Cell = _grid.cells[_current_index]
	cell.enter(_pawn)


func _exit_current_cell():
	var cell: Cell = _grid.cells[_current_index]
	cell.exit(_pawn)


func _set_name(value: String):
	_pawn.name = value
	
	



