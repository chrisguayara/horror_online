extends Control

@onready var texture_rect = $"../scopeset"



func _ready():
	texture_rect.visible = false

func set_scope_overlay(is_scoped: bool):
	texture_rect.visible = is_scoped

func can_open_inventory() -> bool:
	return not texture_rect.visible  
