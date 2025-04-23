extends Node

@export var fail_gold_num: int
@export var _health_lose_when_broke: int


func _on_move_pawn_completed(pawn: Pawn) -> void:
	if pawn.gold < fail_gold_num:
		pawn.status = Pawn.Status.BROKE
		pawn.health -= _health_lose_when_broke

	if pawn.is_dead:
		pawn.status = Pawn.Status.DEAD
		
