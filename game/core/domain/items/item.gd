class_name Item
extends Resource

@export var id: String                # 唯一标识符
@export var name: String              # 显示名称
@export var icon: Texture2D           # 图标
@export var max_stack: int = 1        # 最大堆叠数量
@export var item_type: String         # 类型分类（消耗品/装备/材料）

@export_multiline var description: String


func can_use(user: Object)-> bool:
	return true


# 使用物品的抽象方法（子类需实现）
func use(user: Object)-> void:
	# 事件广播（可能）
	_on_use(user)


func _on_use(user: Object)-> void:
	pass