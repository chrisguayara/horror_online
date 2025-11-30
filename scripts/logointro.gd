extends Control

@onready var logoScreen = $logo
@onready var background = $background
@onready var mainmenu = $mainmenu

func _ready():
	mainmenu.visible = false
func pre():
	logoScreen.modulate.a = 0.0
	logoScreen.visible = false
	await get_tree().process_frame   
	start()

func start():
	logoScreen.visible = true
	
	var tw = get_tree().create_tween()
	tw.tween_property(logoScreen, "modulate:a", 1.0, 0.7) # fade in
	
	await get_tree().create_timer(4.3).timeout
	await finish()

func finish():
	var tw = get_tree().create_tween()
	tw.tween_property(logoScreen, "modulate:a", 0.0, 0.9) # fade out
	
	await tw.finished
	background.visible = false
	logoScreen.visible = false
	var p = get_parent()
	p.mmscreen()
	playmm()

func playmm():
	mainmenu.visible = true
	if Input.is_action_just_pressed("interact"):
		var p = get_parent()
		p.endmmsounds()
		endmm()

func endmm():
	mainmenu.visible = false
