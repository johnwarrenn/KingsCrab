extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass




func _on_start_pressed() -> void:
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	

func _on_options_pressed() -> void:
	var options = load("res://scenes/Options.tscn")
	get_tree().current_scene.add_child(options)



func _on_quit_pressed() -> void:
	get_tree().quit()
