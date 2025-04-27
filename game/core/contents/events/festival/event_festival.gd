extends EventNode

@export var _state_festival: State


func _on_trigger() -> void:
	pawn.state_container.add_state(_state_festival)
	complete_event() # 不要忘记完成事件
