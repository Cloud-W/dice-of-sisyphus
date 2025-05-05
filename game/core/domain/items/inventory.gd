class_name Inventory
extends Resource

# 自定义槽位数据结构
class InventorySlot:
	var item: Item
	var quantity: int


	func _init(_item: Item = null, _quantity: int = 0):
		item = _item
		quantity = _quantity


signal inventory_updated
signal item_added(item: Item, quantity: int)
signal item_removed(item: Item, quantity: int)
@export var capacity := 30  # 基础容量

var _slots: Array[InventorySlot] = []  # 自定义槽位类型
var _item_count_cache: Dictionary[Item, int] = {}


func _init():
	_slots.resize(capacity)
	for i in capacity:
		_slots[i] = InventorySlot.new()


func get_all() ->Array[InventorySlot]:
	return _slots.filter(func (x): return x.item != null)


# 添加物品
# 返回未成功添加的数量
func add_item(item: Item, quantity: int = 1) -> int:
	var remaining: int = quantity

	# 优先堆叠已有物品
	for slot in _slots:
		if slot.item == item and slot.quantity < item.max_stack:
			var can_add = min(item.max_stack - slot.quantity, remaining)
			slot.quantity += can_add
			remaining -= can_add
			if remaining <= 0: break

	# 填充空槽位
	if remaining > 0:
		for i in _slots.size():
			var slot: InventorySlot = _slots[i]
			if slot.item == null:
				var add_qty = min(item.max_stack, remaining)
				slot.item = item
				slot.quantity = add_qty
				remaining -= add_qty
				if remaining <= 0: break

	var actual_added: int = quantity - remaining
	_update_cache(item, actual_added)

	if remaining < quantity:
		inventory_updated.emit()
		item_added.emit(item, actual_added)

	return remaining  # 返回未成功添加的数量


# 移除指定数量的物品
func remove_item(item: Item, quantity: int, force_remove: bool = false) -> bool:
	if quantity <= 0:
		return false

	var item_count: int = get_item_count(item)
	if item_count < quantity and not force_remove:
		print("尝试移除数量超过库存总量")
		return false

	quantity = min(item_count, quantity)
	var remaining_to_remove: int = quantity
	# 反向遍历以避免索引错位
	for i in range(_slots.size()-1, -1, -1):
		var slot: InventorySlot = _slots[i]
		if slot.item == item:
			var remove_amount = min(slot.quantity, remaining_to_remove)
			slot.quantity -= remove_amount
			remaining_to_remove -= remove_amount

			if slot.quantity == 0:
				_slots[i].item = null

			if remaining_to_remove <= 0:
				break

	_update_cache(item, -quantity)

	inventory_updated.emit()
	item_removed.emit(item, quantity)
	return true


# 获取指定物品在库存中的总数量
func get_item_count(item: Item) -> int:
	return _item_count_cache.get(item, 0)


# 检查是否存在指定数量的物品
func has_item(item: Item, quantity: int = 1) -> bool:
	return get_item_count(item) >= quantity


# 批量转移物品到其他库存
# 返回转移数量
func transfer_to(target_inventory: Inventory, item: Item, quantity: int) -> int:
	var available: int  = get_item_count(item)
	var transfer_amount = min(available, quantity)

	if transfer_amount > 0:
		var remaining: int = target_inventory.add_item(item, transfer_amount)
		if remaining < transfer_amount:
			remove_item(item, transfer_amount - remaining)
			return transfer_amount - remaining

	return 0


# 在添加/移除物品时更新缓存
func _update_cache(item: Item, delta: int):
	if item in _item_count_cache:
		_item_count_cache[item] += delta
		if _item_count_cache[item] == 0:
			_item_count_cache.erase(item)
	else:
		_item_count_cache[item] = delta
