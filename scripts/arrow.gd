extends Node2D


var rotation_speed = 4.0
@export var rotation_limit = 80.0
var rotation_direction = 1


func _ready() -> void:
	var difficulty = NavigationManager.difficulty
	NavigationManager.connect("difficulty_changed", _on_update_rotation_speed)
	_on_update_rotation_speed(difficulty)
	

func _process(delta: float) -> void:
	rotation_degrees += rotation_direction * rotation_speed
	if abs(rotation_degrees) >= rotation_limit:
		rotation_direction *= -1

	
func _on_update_rotation_speed(toggled):
	if toggled:
		rotation_speed = 8.0
	else: 
		rotation_speed = 4.0
