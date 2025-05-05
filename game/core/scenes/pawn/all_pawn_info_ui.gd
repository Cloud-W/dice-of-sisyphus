class_name AllPawnInfoUI extends Control

@onready var pawn_info_ui = %PawnInfoUI
@export var pawn_mgr : PawnManager

@export var _current_index : int = 0

func _ready():
	pawn_mgr.on_pawn_created.connect(_on_pawn_created)

func set_pawn_info(pawn : Pawn) -> void:
	pawn_info_ui.pawn = pawn

func _on_previous()-> void:
	_current_index = _current_index - 1
	if _current_index < 0:
		_current_index = pawn_mgr.get_pawn_num() - 1
	_set_pawn()
	

func _on_next()-> void:
	_current_index = _current_index + 1
	if _current_index >= pawn_mgr.get_pawn_num():
		_current_index = 0
	_set_pawn()
	
# Called when a new pawn is created.
func _on_pawn_created(pawn: Pawn) -> void:
	# This function is called from the PawnManager.
	# Set the pawn info UI to the current pawn
	_current_index = pawn_mgr.get_pawn_num() - 1
	_set_pawn()
	# Update the current index to the last created pawn

func _set_pawn() -> void:
	# Set the pawn info UI to the current pawn
	set_pawn_info(pawn_mgr.get_pawn(_current_index).pawn)
