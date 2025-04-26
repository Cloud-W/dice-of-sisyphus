class_name Map extends Node2D

@export var _static_layer : TileMapLayer
@export var _dynamic_layer: TileMapLayer
@export var church: Church

func _ready():
	_dynamic_layer.child_order_changed.connect(_on_dynamic_layer_change)

func _on_dynamic_layer_change():
	for child : Node2D in _dynamic_layer.get_children():
		var coord : Vector2 = _dynamic_layer.local_to_map(child.position)
		_dynamic_layer.set_cell(coord, 0, Vector2i.ZERO, child.get_index())
	pass

func get_start_coordinates() -> Vector2i:
	var cells = _dynamic_layer.get_used_cells_by_id(2)
	assert(cells.size() == 1)
	return cells[0]

func get_start_point()-> Vector2:
	return _get_cell_world_pos(_dynamic_layer,get_start_coordinates())

func get_waypoint_pos(coord: Vector2i) -> Vector2:
	return _get_cell_world_pos(_static_layer, coord)

func _get_cell_world_pos(layer : TileMapLayer, coord : Vector2i) -> Vector2:
	return to_global(layer.map_to_local(coord))

func enter_cell(pawn : Pawn) -> void:
	print("enter cell")
	var index: int = _dynamic_layer.get_cell_alternative_tile(pawn.coordPos)
	if index < 0:
		return
	var event_node: EventNode = _dynamic_layer.get_child(index)
	print((event_node.get_script() as Script).resource_path)
	event_node.church = church
	event_node.pawn = pawn
	await event_node.trigger()
	

func move_pawn(pawn : Pawn, move : int) -> Array[Vector2i]:
	var path : Array[Vector2i] = []
	var next_cell = pawn.coordPos
	var dir = pawn.direction

	path.append(next_cell)

	while move > 0:
		var nn = get_next_cell(next_cell, dir)
		dir = nn - next_cell
		next_cell = nn
		path.append(next_cell)

		move = move - 1
	return path

func get_next_cell(cell : Vector2i, dir : Vector2i) -> Vector2i:
	var possible_tiles : Array[Vector2i] = _static_layer.get_surrounding_cells(cell)

	possible_tiles.erase(cell - dir)
	for c in possible_tiles:
		var tileData : TileData = _static_layer.get_cell_tile_data(c)
		if tileData == null:
			continue
		return c
		
	return Vector2.ZERO
