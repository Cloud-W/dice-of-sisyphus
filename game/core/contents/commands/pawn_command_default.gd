extends PawnCommand

@export var _state_gold_bonus: State

# 

func add_gold(value: int) ->void:
	var state_gold_bonus: State = pawn.state_container.get_state(_state_gold_bonus.id)
	if state_gold_bonus:
		value += state_gold_bonus.count

	print("PawnCommand: add_gold => %s" % value)
	pawn.gold +=value
	