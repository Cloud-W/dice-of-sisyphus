class_name PawnAgent
extends Node2D

@export var pawn: Pawn: set = _set_pawn
@export var _pawn_name: Label
@export var _step_duration: float = 0.5


func _set_pawn(value: Pawn) -> void:
	pawn = value
	if not is_node_ready():
		await ready

	pawn.name_changed.connect(set_pawn_name)
	set_pawn_name()
	pass


func move_to(target_pos: Vector2):
	self.global_position = target_pos


func move_path(path: Array[Vector2], step_completed: Callable):
	for index in range(path.size()):
		var pos: Vector2 =  path[index]
		var tween        := create_tween()
		tween.tween_property(self, "global_position", pos, _step_duration)
		tween.play()
		await tween.finished
		await step_completed.call(index)


func set_pawn_name() -> void:
	_pawn_name.text = pawn.name
