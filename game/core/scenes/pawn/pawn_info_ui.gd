class_name PawnInfoUI
extends PanelContainer

@export var pawn: Pawn: set = _set_pawn

@onready var name_label = %NameLabel
@onready var gold_label = %GoldLabel
@onready var health_label = %HealthLabel
@onready var status_label = %StatusLabel
@onready var inventory_view: InventoryView = %InventoryView


func _set_pawn(value: Pawn) -> void:
	if pawn:
		_disconect_signals()

	pawn = value
	if not is_node_ready():
		await ready

	inventory_view.inventory = pawn.inventory

	_connect_signals()
	_update_pawn()


func _disconect_signals() -> void:
	pawn.name_changed.disconnect(_update_name)
	pawn.gold_changed.disconnect(_update_gold)
	pawn.health_changed.disconnect(_update_health)
	pawn.status_changed.disconnect(_update_status)


func _connect_signals() -> void:
	pawn.name_changed.connect(_update_name)
	pawn.gold_changed.connect(_update_gold)
	pawn.health_changed.connect(_update_health)
	pawn.status_changed.connect(_update_status)


func _update_pawn() -> void:
	_update_name()
	_update_gold()
	_update_health()
	_update_status()


func _update_name() -> void:
	name_label.text = pawn.name


func _update_gold() -> void:
	gold_label.text = str(pawn.gold)


func _update_health() -> void:
	health_label.text = str(pawn.health)


func _update_status() -> void:
	var status_str: String
	match pawn.status:
		Pawn.Status.HARD_BUT_STICK:
			status_str = "艰难但坚持"
		Pawn.Status.BROKE:
			status_str = "破产"
		Pawn.Status.MILLIONAIRE:
			status_str = "百万富翁"
		Pawn.Status.DEAD:
			status_str = "阿伟死了"
		_:
			status_str = "未知"

	status_label.text = status_str

	
