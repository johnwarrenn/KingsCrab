extends Node2D

@export var rotation_speed = 5.0
@export var rotation_limit = 80.0
var rotation_direction = 1

func _process(delta: float) -> void:
	rotation_degrees += rotation_direction * rotation_speed
	if abs(rotation_degrees) >= rotation_limit:
		rotation_direction *= -1
	
	
