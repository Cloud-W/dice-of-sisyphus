class_name InventoryView
extends Control

@export var inventory: Inventory: set = _set_inventory
@export var _item_view_prefab: PackedScene = preload("res://game/core/scenes/item/item_view.tscn")


func _ready() -> void:
	_hide_all_item_views()


func _set_inventory(value: Inventory) ->void:
	if inventory:
		_disconect_signals()

	inventory = value
	if not is_node_ready():
		await ready

	_connect_signals()
	_update_view()


func _disconect_signals() -> void:
	inventory.inventory_updated.disconnect(_update_view)


func _connect_signals() -> void:
	inventory.inventory_updated.connect(_update_view)


func _hide_all_item_views() -> void:
	var children: Array[Node] = self.get_children()
	for child: ItemView in children:
		child.visible = false


func _update_view():
	_hide_all_item_views()

	var slots: Array[Inventory.InventorySlot] = inventory.get_all()
	for slot: Inventory.InventorySlot in slots:
		var item_view: ItemView = _get_next_item_view()
		item_view.update(slot.item, slot.quantity)


func _get_next_item_view() -> ItemView:
	var children: Array[Node] = self.get_children()
	for child: ItemView in children:
		if child.visible == false:
			child.visible = true
			return child

	var item_view: ItemView = _item_view_prefab.instantiate()
	add_child(item_view)
	return item_view