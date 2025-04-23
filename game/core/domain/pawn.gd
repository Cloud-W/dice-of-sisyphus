class_name Pawn
extends Resource

enum Status{
	HARD_BUT_STICK, #艰难但坚持
	BROKE, #破产
	MILLIONAIRE, #百万富翁
	DEAD, #死亡
}
signal gold_changed
signal health_changed
signal name_changed
signal status_changed
@export var name: String: set = _set_name
@export var gold: int: set = _set_gold
@export var health: int: set = _set_health
@export var status: Status = Status.HARD_BUT_STICK: set = _set_status

# 地图上的坐标值
var coordPos: Vector2i;
# 当前移动方向
var direction: Vector2i
var _rand: RandomNumberGenerator = RandomNumberGenerator.new()

var rand: RandomNumberGenerator:
	get:
		return _rand

var is_dead: bool:
	get:
		return health <= 0


func _set_gold(value: int) -> void:
	gold = value
	gold_changed.emit()


func _set_health(value: int) -> void:
	health = value
	health_changed.emit()


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

