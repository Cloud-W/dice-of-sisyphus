extends PawnState

@export var _state_gold_bonus: State
@export var _state_holy_shard: State


func _on_activate() -> void:
	print("====庆典开始了====")
	_state_gold_bonus.count = count
	state_handler.add_state(_state_gold_bonus)

	pawn.events.event_completed.connect(_on_event_completed)


func _on_deactivate() -> void:
	print("====庆典结束了====")
	state_handler.remove_state(_state_gold_bonus.id)
	state_handler.remove_state(_state_holy_shard.id)

	pawn.events.event_completed.disconnect(_on_event_completed)


func _on_event_completed(event_node: EventNode) -> void:
	if event_node is not EventGameOfFortune:
		return
	_state_holy_shard.count = 1
	state_handler.add_state(_state_holy_shard)
