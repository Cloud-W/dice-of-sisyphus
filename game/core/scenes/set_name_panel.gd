class_name SetNamePanel extends PanelContainer

signal on_name_set(value : String)

func _on_name_change(value:String) -> void:
    hide()
    on_name_set.emit(value)
