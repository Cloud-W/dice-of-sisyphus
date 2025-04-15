class_name Pawn
extends Resource

signal gold_changed

@export var name: String
@export var gold: int : set = _set_gold


func _set_gold(value: int) -> void:
	gold = value
	gold_changed.emit()

