extends ParallaxBackground

@export var player: NodePath

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var player_node = get_node(player)
	if player_node:
		scroll_offset = player_node.position
