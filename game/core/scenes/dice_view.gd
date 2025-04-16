class_name DiceView
extends Node2D

signal on_dice_roll(result: int)
@export var anim_time: float = 1.5

@onready var animation: AnimatedSprite2D = %AnimatedSprite2D

var _can_roll: bool = true


func _ready() -> void:
	pass


# result (1, 6)
func roll(result: int) -> void:
	if not _can_roll:
		return
	_can_roll = false

	animation.play("roll");
	await get_tree().create_timer(anim_time).timeout
	animation.play("idle");
	animation.frame = result - 1
	on_dice_roll.emit(result)


func _on_roll_completed(_pawn: Pawn) -> void:
	_can_roll = true
