class_name EventNode extends Node

@export var _animation: AnimatedSprite2D

func _ready():
    if _animation:
        _animation.play("default")

func trigger(pawn : Pawn)->void:
    pass
