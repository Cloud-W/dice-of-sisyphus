class_name State
extends Resource

signal remove_requested(state_id: String)
@export var id: String
@export var name: String

@export_multiline var description: String
@export var icon: Texture
@export var count: int = 0: set = _set_count
@export var duration: int = 0: set = _set_duration

var is_active: bool = false


func activate() -> void:
	if is_active:
		return
	is_active = true
	_on_activate()


func deactivate() -> void:
	if not is_active:
		return
	is_active = false
	_on_deactivate()


func _on_activate() -> void:
	pass


func _on_deactivate() -> void:
	pass


func _set_count(value: int) -> void:
	count = value
	if count <= 0:
		remove()


func _set_duration(value: int) -> void:
	duration = value
	if duration <= 0:
		remove()


func remove() -> void:
	remove_requested.emit(self.id)


func next_turn(turns: int) -> void:
	duration -= turns


