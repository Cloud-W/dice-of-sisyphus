class_name EventTombstone
extends EventNode

@export var died_pawn: Pawn


func _on_stop() -> void:
	print("一个 %s 在这里长眠" % died_pawn.name)

	complete_event() # 不要忘记完成事件
