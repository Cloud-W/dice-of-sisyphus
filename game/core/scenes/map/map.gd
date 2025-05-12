class_name Map
extends Node2D

@export var _static_layer: TileMapLayer
@export var _dynamic_layer: TileMapLayer
@export var _start_point_id: int = 2

@onready var _event_layer: EventCollection = %"EventLayer"


func _ready():
	_dynamic_layer.enabled = false
	_create_event_nodes()


func _create_event_nodes() ->void:
	for coordPos: Vector2i in _dynamic_layer.get_used_cells():
		var scene: PackedScene = _get_scene_tile_scene(_dynamic_layer, coordPos)
		if scene:
			push_event_secne(coordPos, scene)


func _get_scene_tile_scene(tile_map_layer: TileMapLayer, coordPos: Vector2i) -> PackedScene:
	var source_id: int = tile_map_layer.get_cell_source_id(coordPos)
	if source_id <= -1:
		return null

	var scene_source: TileSetSource = tile_map_layer.tile_set.get_source(source_id)
	if scene_source is not TileSetScenesCollectionSource:
			return null

	var alt_id: int = tile_map_layer.get_cell_alternative_tile(coordPos)
	# 分配的 PackedScene。
	return scene_source.get_scene_tile_scene(alt_id)


func push_event_secne(coordPos: Vector2i, event_scene: PackedScene) -> void:
	var event_node: EventNode = event_scene.instantiate()
	push_event(coordPos, event_node)


func push_event(coordPos: Vector2i, event_node: EventNode) -> void:
	event_node.global_position = get_waypoint_pos(coordPos)
	_event_layer.push_event(coordPos, event_node)


func pop_event(coordPos: Vector2i) -> void:
	_event_layer.pop_event(coordPos)


func get_start_coordinates() -> Vector2i:
	var cells: Array[Vector2i] = _dynamic_layer.get_used_cells_by_id(_start_point_id)
	print("起点数量：", cells.size())
	assert(cells.size() == 1)
	return cells[0]


func get_start_point()-> Vector2:
	return _get_cell_world_pos(_dynamic_layer, get_start_coordinates())


func get_waypoint_pos(coord: Vector2i) -> Vector2:
	return _get_cell_world_pos(_static_layer, coord)


func _get_cell_world_pos(layer: TileMapLayer, coord: Vector2i) -> Vector2:
	return to_global(layer.map_to_local(coord))


func get_event_node(coordPos: Vector2i) -> EventNode:
	return _event_layer.get_event(coordPos)

func get_all_event_nodes(coordPos: Vector2i) -> Array[EventNode]:
	return _event_layer.get_all_events(coordPos)


func move_pawn(pawn: Pawn, move: int) -> Array[Vector2i]:
	var path: Array[Vector2i] = []
	var next_cell             = pawn.coord_pos
	var dir                   = pawn.direction

	path.append(next_cell)

	while move > 0:
		var nn = get_next_cell(next_cell, dir)
		dir = nn - next_cell
		next_cell = nn
		path.append(next_cell)

		move = move - 1
	return path


func get_next_cell(cell: Vector2i, dir: Vector2i) -> Vector2i:
	var possible_tiles: Array[Vector2i] = _static_layer.get_surrounding_cells(cell)

	possible_tiles.erase(cell - dir)
	for c in possible_tiles:
		var tileData: TileData = _static_layer.get_cell_tile_data(c)
		if tileData == null:
			continue
		return c

	return Vector2.ZERO


	
