class_name PawnManager extends Node
# PawnManager is a singleton that manages the pawn's state and events.

signal on_pawn_created(pawn: Pawn)

@export var _pawn_agent: PackedScene

var _current_index: int = 0

var _pawns : Array[Pawn] = []
var _pawn_agents : Array[PawnAgent] = []

#测试用
@export var _init_pawn_gold : int = 1000
@export var _init_pawn_health : int = 10

func create_pawn(name : String) -> PawnAgent:
	# Create a new pawn and add it to the _pawns array.
	var pawn = Pawn.new()
	pawn.name = name
	pawn.gold = _init_pawn_gold
	pawn.health = _init_pawn_health
	var agent = _pawn_agent.instantiate()
	_pawn_agents.append(agent)
	_pawns.append(pawn)
	agent.pawn = pawn
	add_child(agent)
	on_pawn_created.emit(pawn)
	return agent

func get_pawn(index: int) -> PawnAgent:
	# Return the pawn at the specified index.
	if index < 0 or index >= _pawns.size():
		return null
	return _pawn_agents[index]

func get_current_pawn() -> PawnAgent:
	return _pawn_agents[_current_index]

func next_pawn() -> void:
	# Move to the next pawn in the _pawns array.
	_current_index = _current_index + 1
	if _current_index >= _pawns.size():
		_current_index = 0


func get_pawn_num() -> int:
	# Return the number of pawns.
	return _pawns.size()
