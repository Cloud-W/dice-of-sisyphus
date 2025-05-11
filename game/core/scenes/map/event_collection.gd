class_name EventCollection
extends Node

class EventStack:
	var _array: Array[EventNode] = []


	func push(event_node: EventNode) -> void:
		_array.append(event_node)


	func pop() -> EventNode:
		return _array.pop_back()


	func peek() -> EventNode:
		return _array.back()


	func is_empty() -> bool:
		return _array.is_empty()


	func size() -> int:
		return _array.size()

#signal event_pushed(coordPos: Vector2i, event_node: EventNode)
#signal event_poped(coordPos: Vector2i, event_node: EventNode)

var _event_map: Dictionary[Vector2i,EventStack] = {}


func get_event(coordPos: Vector2i) -> EventNode:
	var stack: EventStack = _event_map.get(coordPos)
	if stack == null:
		return null

	return stack.peek()


func push_event(coordPos: Vector2i, event_node: EventNode) -> void:
	var stack: EventStack = _event_map.get(coordPos)
	if stack == null:
		stack = EventStack.new()
		_event_map[coordPos] = stack
	else:
		var origin_node: EventNode = stack.peek()
		if origin_node:
			remove_child(origin_node)

	stack.push(event_node)
	add_child(event_node)


func pop_event(coordPos: Vector2i) -> EventNode:
	var stack: EventStack = _event_map.get(coordPos)
	if stack == null:
		return null

	var poped: EventNode = stack.pop()
	remove_child(poped)

	var previous: EventNode = stack.peek()
	if previous:
		add_child(previous)

	return poped
		
  

