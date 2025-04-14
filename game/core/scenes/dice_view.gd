class_name DiceView extends Node2D

@export var anim_time : float = 1.5

@onready var animation : AnimatedSprite2D = %AnimatedSprite2D

func _ready() -> void:
    pass
    

func roll() -> int:
    var result : int = randi_range(0, 5)
    animation.play("roll");
    await get_tree().create_timer(anim_time).timeout
    animation.play("idle");
    animation.frame = result
    return result + 1
