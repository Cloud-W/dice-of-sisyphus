extends State

@export var _state_gold_bonus: State


func _on_activate() -> void:
	print("====庆典开始了====")
	_state_gold_bonus.count = count
	state_handler.add_state(_state_gold_bonus)
	

func _on_deactivate() -> void:
	print("====庆典结束了====")
	state_handler.remove_state(_state_gold_bonus.id)
	
