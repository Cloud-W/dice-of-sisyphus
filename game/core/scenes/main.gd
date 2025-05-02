extends Node2D

signal setup_pawn_requested(pawn: Pawn)
signal move_pawn_completed(pawn: Pawn)
#signal roll_requested(result: int)

@export var _pawn: Pawn
@export var _church: Church
@export var _is_auto_roll: bool
@export var _map: Map

# 测试用
@export var _debug_move_step: int = -1
@export var _pawn_num : int = 2
@export var _init_with_test_pawns : bool = true

@onready var _pawn_manager : PawnManager = %PawnManager
@onready var _pawn_agent: PawnAgent = %PawnAgent
@onready var _diceView: DiceView = %DiceView

func _ready() -> void:
	_map.church = _church
	# _init_pawn(_pawn)
	#_create_test_pawn()
	if _init_with_test_pawns:
		_create_test_pawn()


func _create_test_pawn() -> void:
	# Create a new pawn and add it to the _pawns array.
	for i in range(_pawn_num):
		var name = "pawn_agent" + str(i)
		create_pawn(name)


func create_pawn(value: String) -> void:
	print("create_pawn")
	# Create a new pawn and add it to the _pawns array.
	var pawn_agent = _pawn_manager.create_pawn(value)
	print(pawn_agent)
	_init_pawn_agent(pawn_agent)
	
func _init_pawn_agent(pawn_agent: PawnAgent) -> void:
	var pawn : Pawn = pawn_agent.pawn
	setup_pawn_requested.emit(pawn)

	pawn.direction = Vector2(1, 0)
	print("地图对象：", _map.name)
	pawn.coordPos = _map.get_start_coordinates()
	
	pawn_agent.move_to(_map.get_start_point())

	# 确保每次角色进入格子时地图是更新完毕的
	# 后续可以把call_deferred封装进enter_cell方法里
	_map.call_deferred("enter_cell", _pawn)
	pass

func start_roll() -> void:
	_roll_dice()


func _move_pawn(step: int):
	_exit_current_cell()

	var pawn_agent: PawnAgent = _pawn_manager.get_current_pawn()
	var pawn: Pawn = pawn_agent.pawn

	var path: Array[Vector2i] = _map.move_pawn(pawn, step)

	pawn.direction = path[-1] - path[-2]
	pawn.coordPos = path[-1]

	var path_positions: Array[Vector2] = []
	for i in range(1, path.size()):
		path_positions.append(_map.get_waypoint_pos(path[i]))

	await pawn_agent.move_path(path_positions)
	# 处理时间的流逝
	pawn.state_container.next_turn(step)
	_church.state_container.next_turn(step)

	await _enter_current_cell(pawn)
	move_pawn_completed.emit(pawn)
	_pawn_manager.next_pawn()

	if _is_auto_roll and not pawn.is_dead:
		_roll_dice()


func _roll_dice() -> void:
	var pawn_num = _pawn_manager.get_pawn_num()
	if pawn_num == 0:
		return
	
	var pawn_agent: PawnAgent = _pawn_manager.get_current_pawn()
	var pawn: Pawn = pawn_agent.pawn

	var result: int
	if _debug_move_step > 0:
		result = _debug_move_step
	else:
		result = pawn.roll_dice()

	_diceView.roll(result)


func _enter_current_cell(pawn : Pawn):
	await _map.enter_cell(pawn)


func _exit_current_cell():
	# TODO
	pass


func _set_name(value: String):
	_pawn.name = value
