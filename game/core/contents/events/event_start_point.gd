class_name EventStartPoint
extends EventNode

@export var _item: Item
@export var _max_use: int = 3


func has_pass_event() -> bool:
	return true


func _on_stop() -> void:
	print("兜兜转转一圈，我又回来了吗...")
	pawn.command.add_gold(100)
	complete_event()


func _on_pass() -> void:
	# 吃维持餐
	var item_count: int = pawn.inventory.get_item_count(_item)
	var use_count: int  = min(item_count, _max_use)
	pawn.command.use_item(_item, use_count)
	pawn.events.day_finished.emit()
	complete_event()

