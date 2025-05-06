extends EventNode

@export var _state_festival: State


func _on_stop() -> void:
	pawn.state_container.add_state(_state_festival)
	complete_event() # 不要忘记完成事件

	
# festival_service
# _handle_event_complate(string event_name, pawn)
	# if pawn.has_state():
	#   do_some()
