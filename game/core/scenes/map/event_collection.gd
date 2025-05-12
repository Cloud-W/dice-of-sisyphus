class_name EventCollection
extends Node

class EventStack:
	var _array: Array[EventNode] = []

	
	func push(event_node: EventNode) -> void:
		_array.append(event_node)


	func pop() -> EventNode:
		return _array.pop_back()


	func remove(event_node: EventNode) -> void:
		_array.erase(event_node)


	func contains(event_node: EventNode) -> bool:
		return _array.has(event_node)


	func peek() -> EventNode:
		return _array.back()


	func get_all() -> Array[EventNode]:
		return _array


	func is_empty() -> bool:
		return _array.is_empty()


	func size() -> int:
		return _array.size()

#signal event_pushed(coord_pos: Vector2i, event_node: EventNode)
#signal event_poped(coord_pos: Vector2i, event_node: EventNode)

var _event_map: Dictionary[Vector2i,EventStack] = {}


func get_event(coord_pos: Vector2i) -> EventNode:
	var stack: EventStack = _event_map.get(coord_pos)
	if stack == null:
		return null

	return stack.peek()


func get_all_events(coord_pos: Vector2i) -> Array[EventNode]:
	var stack: EventStack = _event_map.get(coord_pos)
	if stack == null:
		return []

	return stack.get_all()


func push_event(coord_pos: Vector2i, event_node: EventNode) -> void:
	var stack: EventStack = _event_map.get(coord_pos)
	if stack == null:
		stack = EventStack.new()
		_event_map[coord_pos] = stack
	else:
		var origin_node: EventNode = stack.peek()
		if origin_node:
			remove_child(origin_node)

	stack.push(event_node)
	add_child(event_node)


func pop_event(coord_pos: Vector2i) -> EventNode:
	var stack: EventStack = _event_map.get(coord_pos)
	if stack == null:
		return null

	var poped: EventNode = stack.pop()
	remove_child(poped)
	poped.queue_free()

	var previous: EventNode = stack.peek()
	if previous:
		add_child(previous)

	return poped


func erase_event(event_node: EventNode) -> void:
	var coord_pos: Vector2i = event_node.coord_pos
	var stack: EventStack   = _event_map.get(coord_pos)
	if stack == null:
		return

	if not stack.contains(event_node):
		return

	var is_last: bool = stack.peek() == event_node
	if is_last:
		stack.remove(event_node)
		remove_child(event_node)
		event_node.queue_free()

		if not stack.is_empty():
			add_child(stack.peek())
			
	else:
		stack.remove(event_node)
		
		
  
