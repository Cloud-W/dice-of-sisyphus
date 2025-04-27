extends Node2D

signal setup_pawn_requested(pawn: Pawn)
signal move_pawn_completed(pawn: Pawn)
#signal roll_requested(result: int)
@export var _debug_move_step: int = -1
@export var _pawn: Pawn
@export var _church: Church
@export var _is_auto_roll: bool
@export var _map: Map

@onready var _pawn_agent: PawnAgent = %PawnAgent
@onready var _diceView: DiceView = %DiceView


func _ready() -> void:
	_map.church = _church
	setup_pawn_requested.emit(_pawn)

	_pawn.direction = Vector2(1, 0)
	_pawn.coordPos = _map.get_start_coordinates()
	
	_pawn_agent.move_to(_map.get_start_point())

	# 确保每次角色进入格子时地图是更新完毕的
	# 后续可以把call_deferred封装进enter_cell方法里
	_map.call_deferred("enter_cell", _pawn)


func start_roll() -> void:
	_roll_dice()


func _move_pawn(step: int):
	_exit_current_cell()

	var path: Array[Vector2i] = _map.move_pawn(_pawn_agent._pawn, step)

	_pawn.direction = path[-1] - path[-2]
	_pawn.coordPos = path[-1]

	var path_positions: Array[Vector2] = []
	for i in range(1, path.size()):
		path_positions.append(_map.get_waypoint_pos(path[i]))

	await _pawn_agent.move_path(path_positions)
	# 处理时间的流逝
	_pawn.state_container.next_turn(step)
	_church.state_container.next_turn(step)

	await _enter_current_cell()
	move_pawn_completed.emit(_pawn)

	if _is_auto_roll and not _pawn.is_dead:
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
	# TODO
	pass


func _set_name(value: String):
	_pawn.name = value
	
	
