extends Node2D

@export var item: Item
@export var test_pawn: Pawn
@export var pawn_command: PawnCommand

@onready var _add_item_quantity: LineEdit = %AddItemQuantity


func _ready() -> void:
	test_pawn.command = pawn_command
	print("wtf :")
	print("wtf :", test_pawn.command == null)


func _on_button_add_pressed() -> void:
	var text: String = _add_item_quantity.text
	if not text:
		return
	var quantity := int(text)
	test_pawn.inventory.add_item(item, quantity)
	print("add %s: %s" % [item.name, quantity])


func _on_button_use_pressed() -> void:
	if not test_pawn.inventory.has_item(item):
		return

	test_pawn.command.use_item(item, 1)
