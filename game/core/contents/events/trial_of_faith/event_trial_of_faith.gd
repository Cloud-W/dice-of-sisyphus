extends EventNode

@export var _gold : int

func _on_trigger(pawn: Pawn) -> void:
	pawn.gold += _gold
	print("开始祈祷")
	await get_tree().create_timer(5.0).timeout
	print("啊！祈祷结束了")
	complete_event()
