extends Control
signal back_pressed

func _on_difficulty_toggled(toggled_on: bool) -> void:
	NavigationManager.difficulty = toggled_on
	NavigationManager.emit_signal("difficulty_changed", toggled_on)
	



func _on_back_pressed() -> void:
	self.visible = false
	back_pressed.emit()
	
	
	
	
	
	
