extends Control

@onready var texture_rect = $TextureRect
var scoped = false

func _ready():
	texture_rect.visible = false
	
func scope(isScoped: bool):
	texture_rect.visible = isScoped
