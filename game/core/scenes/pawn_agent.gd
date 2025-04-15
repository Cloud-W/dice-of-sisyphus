class_name PawnAgent
extends Node2D

func move_to(target_pos: Vector2):
	self.global_position = target_pos

func move_path(path: Array[Vector2]):
	for pos in path:
		var tween := create_tween()
		tween.tween_property(self, "global_position", pos, 0.5)
		tween.play()
		await tween.finished

