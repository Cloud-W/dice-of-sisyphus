extends EventNode

@export var _gold: int


func _on_trigger() -> void:
	print("event_game_of_fortune: %s" % _gold)
	pawn.command.add_gold(_gold)

	complete_event()
