class_name EventNode
extends Node
signal event_completed
@export var pawn: Pawn
@export var church: Church
@export var _animation: AnimatedSprite2D

var is_completed: bool = false


func _ready():
	if _animation:
		_animation.play("default")


func trigger()->void:
	is_completed = false
	_on_trigger()
	if not is_completed:
		await event_completed


func _on_trigger()->void:
	pass


# 具体事件需要调用事件完成
func complete_event() -> void:
	is_completed = true
	event_completed.emit()