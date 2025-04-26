extends EventNode

func _on_trigger() -> void:
	print("事件触发了！")
	complete_event() # 不要忘记完成事件