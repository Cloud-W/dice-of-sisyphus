class_name ItemView
extends Control

@onready var _icon: TextureRect = %Icon
@onready var _quantity: Label = %Quantity


func update(item: Item, quantity: int)-> void:
	_icon.texture = item.icon
	_quantity.text = str(quantity)
