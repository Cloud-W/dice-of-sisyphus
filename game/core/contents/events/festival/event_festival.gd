extends EventNode

@export var _state_festival: State
@export var _state_gold_bonus: State


func _on_trigger() -> void:
	pawn.state_handler.add_state(_state_festival)
	
	_state_gold_bonus.duration = _state_festival.duration
	_state_gold_bonus.count = _state_festival.count
	pawn.state_handler.add_state(_state_gold_bonus)
	complete_event() # 不要忘记完成事件
