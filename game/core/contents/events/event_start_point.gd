class_name EventStartPoint
extends EventNode

func _on_trigger() -> void:
	print("兜兜转转一圈，我又回来了吗...")
	pawn.command.add_gold(100)
	complete_event()
