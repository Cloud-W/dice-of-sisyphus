class_name EventTombstone
extends EventNode

@export var died_pawn: Pawn

func has_pass_event() -> bool:
	return true
	
	
func _on_stop() -> void:
	print("%s 被 %s 打扰了，决定离开这里" % [died_pawn.name, pawn.name])
	map.erase_event(self)
	complete_event() # 不要忘记完成事件


func _on_pass() -> void:
	print("一个 %s 在这里长眠" % died_pawn.name)
	complete_event() # 不要忘记完成事件
