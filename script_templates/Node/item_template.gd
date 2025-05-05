extends Item

@export var effect_value :int


func can_use(user: Object)-> bool:
	return true

func _on_use(user: Object) -> void:
	print("使用物品: %s" % self.name)
