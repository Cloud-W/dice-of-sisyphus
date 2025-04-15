class_name GoldEvent
extends Event

@export var _gold : int

func trigger(pawn: Pawn) -> void:
	pawn.gold += _gold
	
	


