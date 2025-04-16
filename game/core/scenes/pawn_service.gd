extends Node

@export var fail_gold_num: int


func _on_move_pawn_completed(pawn: Pawn) -> void:
	if pawn.gold < fail_gold_num:
		pawn.status = Pawn.Status.BROKE
		
