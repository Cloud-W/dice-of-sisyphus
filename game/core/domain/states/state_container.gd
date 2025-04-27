class_name StateContainer
extends StateHandler

var states: Dictionary[String, State] = {}


func has_state(state_id: String) -> bool:
	return states.has(state_id)


func get_state(state_id: String) -> State:
	return states.get(state_id)


func add_state(state: State) -> void:
	if not state:
		return

	if not states.has(state.id):
		var state_instance: State = state.duplicate()
		states[state.id] = state_instance
		state_instance.state_handler = self
		new_state_added.emit(state_instance)
		state_instance.activate()
	else:
		states[state.id].count += state.count
		# 可以改成 state.update(count, duration)
		# - update_mode: add | replace | ignore
		# - raise_event
		#states[state.id].duration += state.duration


func remove_state(state_id: String) -> void:
	assert(state_id)

	if states.has(state_id):
		var state = states[state_id]
		states.erase(state_id)
		state.deactivate()


func next_turn(turns: int = 1) -> void:
	for state: State in states.values():
		state.next_turn(turns)
	
	
	
