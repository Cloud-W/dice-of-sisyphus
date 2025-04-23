class_name EventStartPoint extends EventNode

func _on_trigger(pawn : Pawn) -> void:
    print("兜兜转转一圈，我又回来了吗...")
    pawn.gold += 100
    complete_event()
