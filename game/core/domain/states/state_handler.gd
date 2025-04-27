class_name StateHandler
extends Resource

signal new_state_added(state: State)

func has_state(state_id: String) -> bool:
	return false


func get_state(state_id: String) -> State:
	return null


func add_state(state: State) -> void:
	pass


func remove_state(state_id: String) -> void:
	pass