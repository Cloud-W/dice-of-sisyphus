class_name Pawn
extends Resource

enum Status{
	HARD_BUT_STICK, #艰难但坚持
	BROKE, #破产
	MILLIONAIRE, #百万富翁
}
signal gold_changed
signal name_changed
signal status_changed
@export var name: String: set = _set_name
@export var gold: int: set = _set_gold
@export var status: Status = Status.HARD_BUT_STICK: set = _set_status

var _rand: RandomNumberGenerator = RandomNumberGenerator.new()


func _set_gold(value: int) -> void:
	gold = value
	gold_changed.emit()


func _set_name(value: String) -> void:
	name = value
	_generate_seed_from_name(value)
	name_changed.emit()


func _set_status(value: Status) -> void:
	status = value
	status_changed.emit()


func _generate_seed_from_name(value: String) -> void:
	var h: int = value.hash()
	print(h)
	_rand.seed = h


func roll_dice() -> int:
	return _rand.randi_range(1, 6)





