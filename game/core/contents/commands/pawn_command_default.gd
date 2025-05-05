extends PawnCommand

@export var _state_gold_bonus: State


func add_gold(value: int) ->void:
	var state_gold_bonus: State = pawn.state_container.get_state(_state_gold_bonus.id)
	if state_gold_bonus:
		value += state_gold_bonus.count

	print("PawnCommand: add_gold => %s" % value)
	pawn.gold +=value


func minus_gold(value: int) ->void:
	pawn.gold = max(pawn.gold - value, 0)


func add_health(value: int) ->void:
	pawn.health += value


# 可选：可以添加血量上限限制逻辑


func minus_health(value: int) ->void:
	pawn.health = max(pawn.health - value, 0)


func add_item(item: Item, quantity: int) ->void:
	pawn.inventory.add_item(item, quantity)
	print("获得物品: %s [%s]" % [item.name, quantity])


func use_item(item: Item, quantity: int) ->void:
	if not pawn.inventory.has_item(item, quantity):
		return

	pawn.inventory.remove_item(item, quantity)
	item.use(self)