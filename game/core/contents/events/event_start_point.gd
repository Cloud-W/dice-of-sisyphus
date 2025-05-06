class_name EventStartPoint
extends EventNode

func has_pass_event() -> bool:
	return true

func _on_stop() -> void:
	print("兜兜转转一圈，我又回来了吗...")
	pawn.command.add_gold(100)
	complete_event()


func _on_pass() -> void:
	print("我还没有找到出口呢，再转转吧...")
	complete_event()

