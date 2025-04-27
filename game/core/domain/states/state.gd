class_name State
extends Resource

@export var id: String
@export var name: String

@export_multiline var description: String
@export var icon: Texture
@export var count: int = 0: set = _set_count
@export var duration: int = 0: set = _set_duration

# bool is_count_stackable => +count | = count | return
# bool is_duration_stackable => +duration | = duration | return
#

var is_active: bool = false
var state_handler: StateHandler


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

func _on_count_changed() -> void:
	pass


func _set_count(value: int) -> void:
	count = value
	_on_count_changed()
	if count <= 0 and state_handler:
		state_handler.remove_state(self.id)


func _set_duration(value: int) -> void:
	duration = value
	



func next_turn(turns: int) -> void:
	if duration < 0:
		return

	duration -= turns
	if duration <= 0:
		state_handler.remove_state(self.id)
