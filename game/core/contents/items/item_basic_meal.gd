extends Item

@export var effect_value: int


func can_use(user: Object)-> bool:
	return user.has_method("add_health")


func _on_use(user: Object) -> void:
	print("使用物品: %s" % self.name)
	user.call("add_health", effect_value)
	
