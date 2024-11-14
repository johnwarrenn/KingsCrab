extends Node

func _ready() -> void:
	
	await TransitionScreen.on_transition_finished()
	get_tree().change_scene_to_file("res://scenes/main.tscn")
