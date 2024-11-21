extends Control
@onready var menu_buttons: VBoxContainer = $MenuButtons
@onready var options = load("res://scenes/options.tscn").instantiate()

signal switch_to_main

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	options.connect("back_pressed", _change_visibility)
	options.visible = false
	get_tree().current_scene.add_child(options)
	



func _on_start_pressed() -> void:
	
	NavigationManager.scene_to_switch = preload("res://scenes/main.tscn")
	NavigationManager.emit_signal("switch_to_main")
	TransitionScreen.transition()


func _on_options_pressed() -> void:
	get_tree().current_scene.add_child(options)
	options.visible = true
	menu_buttons.visible = false



func _on_quit_pressed() -> void:
	get_tree().quit()

func _change_visibility():
	
	menu_buttons.visible = true
