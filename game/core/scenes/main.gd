extends Node2D

signal move_pawn_completed(pawn: Pawn)
#signal roll_requested(result: int)
@export var _debug_move_step: int = -1
@export var _grid: Grid
@export var _pawn: Pawn
@export var _is_auto_roll: bool
@export var _map: Map

@onready var _grid_view: GridView = %GridView
@onready var _pawn_agent: PawnAgent = %PawnAgent
@onready var _diceView: DiceView = %DiceView

var _current_index: int = 0


func _ready() -> void:
	_grid.set_up()
	_grid_view.grid = _grid

	_pawn.direction = Vector2(1, 0)
	_pawn_agent._pawn.coordPos = _map.get_start_coordinates()
	_pawn_agent.move_to(_map.get_start_point())
	#_diceView.global_position = _grid_view.get_grid_center()
	#_map.enter_cell(_pawn_agent._pawn)

	# 确保每次角色进入格子时地图是更新完毕的
	# 后续可以把call_deferred封装进enter_cell方法里
	_map.call_deferred("enter_cell", _pawn_agent._pawn)


func start_roll() -> void:
	_roll_dice()


func _move_pawn(step: int):
	_exit_current_cell()

	#var index: int = _current_index + step;
	#var path: Array[int] = _grid.get_move_path(_current_index, index)
	#_current_index = _grid.get_valid_index(index)
	#await _pawn_agent.move_path(path_positions)
	var path: Array[Vector2i] = _map.move_pawn(_pawn_agent._pawn, step)

	_pawn.direction = path[-1] - path[-2]
	_pawn.coordPos = path[-1]

	var path_positions: Array[Vector2] = []
	for i in range(1, path.size()):
		path_positions.append(_map.get_waypoint_pos(path[i]))

	await _pawn_agent.move_path(path_positions)
	await _enter_current_cell()
	move_pawn_completed.emit(_pawn)

	if _is_auto_roll and _pawn.status != Pawn.Status.BROKE:
		_roll_dice()


func _roll_dice() -> void:
	var result: int
	if _debug_move_step > 0:
		result = _debug_move_step
	else:
		result = _pawn.roll_dice()
	
	_diceView.roll(result)


func _enter_current_cell():
	await _map.enter_cell(_pawn)


func _exit_current_cell():
	var cell: Cell = _grid.cells[_current_index]
	cell.exit(_pawn)


func _set_name(value: String):
	_pawn.name = value
	
	
