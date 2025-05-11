class_name EventTombstone
extends EventNode

@export var diedPawn: Pawn


func _on_stop() -> void:
	print("一个 %s 在这里长眠" % diedPawn.name)

	complete_event() # 不要忘记完成事件
