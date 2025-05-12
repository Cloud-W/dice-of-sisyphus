class_name EventNode
extends Node2D
signal event_completed
@export var pawn: Pawn
@export var church: Church
@export var _animation: AnimatedSprite2D

var coord_pos: Vector2i
var map: Map

var is_completed: bool = false


func _ready():
	if _animation:
		_animation.play("default")


func has_pass_event() -> bool:
	return false


func trigger_stop()->void:
	print("trigger_stop:", (get_script() as Script).resource_path)
	is_completed = false
	_on_stop()
	if not is_completed:
		await event_completed


func trigger_pass()->void:
	print("trigger_pass:", (get_script() as Script).resource_path)
	if not has_pass_event():
		return

	is_completed = false
	_on_pass()
	if not is_completed:
		await event_completed


func _on_stop()->void:
	pass


func _on_pass()->void:
	pass


# 具体事件需要调用事件完成
func complete_event() -> void:
	is_completed = true
	event_completed.emit()