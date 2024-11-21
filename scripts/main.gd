extends Node2D

@onready var game_options = load("res://scenes/game_options.tscn").instantiate()
@onready var player = $Player

#TODO: pause game when the player hits esc
#finish music and implement music
#music slider in menu and game options

func _ready() -> void:
	game_options.visible = false
	process_mode = self.PROCESS_MODE_ALWAYS
	
	# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		if get_tree().paused == false:
			handle_game_options()
			get_tree().paused = true
		else:
			get_tree().paused = false
			game_options.visible = false
			
		
		
func handle_game_options():
	player.add_child(game_options)
	game_options.visible = true
	
