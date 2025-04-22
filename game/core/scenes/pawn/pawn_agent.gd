class_name PawnAgent
extends Node2D

@export var _pawn: Pawn: set = _set_pawn
@export var _pawn_name: Label


func _set_pawn(pawn: Pawn) -> void:
	_pawn = pawn
	if not is_node_ready():
		await ready

	_pawn.name_changed.connect(set_pawn_name)
	pass



func move_to(target_pos: Vector2):
	self.global_position = target_pos


func move_path(path: Array[Vector2]):
	for pos in path:
		var tween := create_tween()
		tween.tween_property(self, "global_position", pos, 0.5)
		tween.play()
		await tween.finished


func set_pawn_name() -> void:
	_pawn_name.text = _pawn.name
