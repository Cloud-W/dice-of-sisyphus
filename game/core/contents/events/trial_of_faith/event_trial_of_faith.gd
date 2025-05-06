extends EventNode

@export var _max_try: int = 3
@export var _health_limit: int
@export var _gold_limit: int
@export var _lose_health: int
@export var _gain_gold_range: Vector2i


func _on_stop() -> void:
	if pawn.health < _health_limit or pawn.gold < _gold_limit:
		complete_event()
		return

	var try_count: int = 0
	while try_count < _max_try:
		try_count += 1
		pawn.health -= _lose_health * try_count
		if pawn.is_dead:
			break

		print("祈祷中...")
		await get_tree().create_timer(1.0).timeout
		var gain_gold: int = pawn.rand.randi_range(_gain_gold_range.x, _gain_gold_range.y)
		print("祈祷成功，获得信仰: " + str(gain_gold))
		pawn.command.add_gold(gain_gold)

		if pawn.rand.randi_range(0, 100) < 50:
			print("祈祷失败了，生活继续")
			break

	print("祈祷结束")
	complete_event()
