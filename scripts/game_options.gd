extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = self.PROCESS_MODE_ALWAYS


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_exit_pressed() -> void:
	get_tree().paused = false
	self.visible = false
	NavigationManager.scene_to_switch = preload("res://scenes/main_menu.tscn")
	NavigationManager.emit_signal("switch_to_menu")
	TransitionScreen.transition()
