class_name Cell
extends Resource

@export var event: Event

var index: int


func enter(pawn: Pawn):
	event.trigger(pawn)


func exit(pawn: Pawn):
	pass