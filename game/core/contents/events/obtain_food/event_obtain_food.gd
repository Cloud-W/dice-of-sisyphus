extends EventNode

@export var item: Item
@export var quantity: int = 1


func _on_trigger() -> void:
	assert(item != null)
	
	pawn.command.add_item(item, quantity)

	complete_event() # 不要忘记完成事件
