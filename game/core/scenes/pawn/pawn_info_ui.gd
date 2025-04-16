class_name PawnInfoUI
extends PanelContainer

@export var pawn: Pawn: set = _set_pawn
@onready var name_label = %NameLabel
@onready var gold_label = %GoldLabel
@onready var status_label = %StatusLabel


func _set_pawn(value: Pawn) -> void:
	if pawn:
		_disconect_signals()

	pawn = value
	if not is_node_ready():
		await ready

	_connect_signals()
	_update_pawn()


func _disconect_signals() -> void:
	pawn.name_changed.disconnect(_update_name)
	pawn.gold_changed.disconnect(_update_gold)
	pawn.status_changed.disconnect(_update_status)


func _connect_signals() -> void:
	pawn.name_changed.connect(_update_name)
	pawn.gold_changed.connect(_update_gold)
	pawn.status_changed.connect(_update_status)


func _update_pawn() -> void:
	_update_name()
	_update_gold()
	_update_status()


func _update_name() -> void:
	name_label.text = pawn.name


func _update_gold() -> void:
	gold_label.text = str(pawn.gold)


func _update_status() -> void:
	status_label.text = pawn.status
