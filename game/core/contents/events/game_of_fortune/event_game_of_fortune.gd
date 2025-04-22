extends EventNode

@export var _gold : int

func trigger(pawn: Pawn) -> void:
	pawn.gold += _gold
