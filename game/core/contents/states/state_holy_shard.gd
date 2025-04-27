extends PawnState

@export var _collect_target: int
@export var _gold_reward: int


func _on_count_changed() -> void:
	print("残片数量：%s" % count)

	if count != _collect_target:
		return
	 
	print("残片收集完成！召唤神龙！")
	pawn.command.add_gold(_gold_reward)
	
	state_handler.remove_state(self.id)
	


		