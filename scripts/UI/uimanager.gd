extends Control

@onready var texture_rect = $scopeset
@onready var inventory_menu = $InventoryMenu

var scoped = false

func _ready():
	texture_rect.visible = false
	inventory_menu.visible = false
func scope(isScoped: bool):
	texture_rect.visible = isScoped
