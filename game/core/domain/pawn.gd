class_name Pawn
extends Resource

signal gold_changed
signal name_changed(value : String)

@export var name : String : set = _set_name
@export var gold: int : set = _set_gold

var _rand : RandomNumberGenerator = RandomNumberGenerator.new()

func _set_gold(value: int) -> void:
	gold = value
	gold_changed.emit()

func _set_name(value : String) -> void:
	name = value
	_generate_seed_from_name(value)
	name_changed.emit(value)


func _generate_seed_from_name(value : String) -> void:
	var h : int = value.hash()
	print(h)
	_rand.seed = h

