extends Node
@export var map: Map
@export var _pawn_command: PawnCommand
@export var fail_gold_num: int
@export var _health_lose_when_broke: int
@export var _event_tombstone: PackedScene


func _setup_pawn(pawn: Pawn) -> void:
	print(pawn.name)
	pawn.command = _pawn_command
	pawn.state_container.new_state_added.connect(_pawn_on_new_state_added.bind(pawn))


func _on_move_pawn_completed(pawn: Pawn) -> void:
	if pawn.gold < fail_gold_num:
		pawn.status = Pawn.Status.BROKE
		pawn.health -= _health_lose_when_broke

	if pawn.is_dead:
		pawn.status = Pawn.Status.DEAD
		var instance_event: EventTombstone = _event_tombstone.instantiate()
		instance_event.died_pawn = pawn
		map.push_event(pawn.coord_pos, instance_event)


func _pawn_on_new_state_added(state: State, pawn: Pawn) -> void:
	if state is PawnState:
		state.pawn = pawn
		
	
