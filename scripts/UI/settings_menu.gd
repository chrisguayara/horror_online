extends Panel

@onready var slider = $MouseSensitivitySlider
@onready var value_label = $Label
var player_head : Node = null

func _ready():
	visible = false
	player_head = get_tree().get_root().get_node("Main/SubViewport/player/head")

	slider.min_value = 0.0005   # slowest
	slider.max_value = 0.01     # fastest
	slider.step = 0.0001
	slider.value = player_head.mouse_sensitivity

	slider.connect("value_changed", Callable(self, "_on_slider_value_changed"))

func _on_slider_value_changed(value):
	if player_head:
		player_head.set_sensitivity(value)
	if value_label:
		value_label.text = "Sensitivity: %.4f" % value

func toggle():
	visible = not visible
