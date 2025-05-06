extends EventNode

func has_pass_event() -> bool:
	return true


func _on_stop() -> void:
	print("停留事件触发了！")
	complete_event() # 不要忘记完成事件


func _on_pass()->void:
	print("路过事件触发了！")
	complete_event() # 不要忘记完成事件
