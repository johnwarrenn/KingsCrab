extends Node

var menu_scene = load("res://scenes/main_menu.tscn")
var main_scene = load("res://scenes/main.tscn")

var difficulty = false
var scene_to_switch : PackedScene

signal difficulty_changed(new_difficulty)
signal switch_to_main
signal switch_to_menu


func _ready() -> void:
	switch_to_main.connect(switch_to_main_scene)
	switch_to_menu.connect(switch_to_menu_scene)
	
	
	
func switch_to_main_scene():
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_packed(main_scene)
	
func switch_to_menu_scene():
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_packed(menu_scene)
	

	
