class_name AddPawnPanel extends PanelContainer

signal on_pawn_add(value : String)

func _on_name_change(value:String) -> void:
    on_pawn_add.emit(value)
