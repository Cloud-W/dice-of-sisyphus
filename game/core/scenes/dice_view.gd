class_name DiceView
extends Node2D

signal on_dice_roll(result: int)
@export var anim_time: float = 1.5

@onready var animation: AnimatedSprite2D = %AnimatedSprite2D

var _can_roll: bool = true


func _ready() -> void:
	pass


func roll() -> void:
	if not _can_roll:
		return
	_can_roll = false
	
	var result: int = randi_range(0, 5)
	animation.play("roll");
	await get_tree().create_timer(anim_time).timeout
	animation.play("idle");
	animation.frame = result
	on_dice_roll.emit(result + 1)


func _on_roll_completed() -> void:
	_can_roll = true
