extends Label

@export var pawn: Pawn: set = _set_pawn


func _set_pawn(value: Pawn) -> void:
	if pawn:
		pawn.gold_changed.disconnect(_update_gold)

	pawn = value
	if not is_node_ready():
		await ready
		
	pawn.gold_changed.connect(_update_gold)
	
	_update_gold()	


func _update_gold() -> void:
	text = str(pawn.gold)

