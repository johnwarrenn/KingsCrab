extends CharacterBody2D

const acceleration = 50
const friction = 70

@onready var animated_sprite_2D = $AnimatedSprite2D
@onready var max_jumps = 2

@export var move_speed = 200
@export var jump_height : float
@export var jump_time_to_peak: float
@export var jump_time_to_descent: float

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1
@onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1
@onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1


func _ready() -> void:
	var velocity := Vector2.ZERO
	animated_sprite_2D.play("idle")
	
	
func _physics_process(delta):
	velocity.y += gravity() * delta
	var horizontal := 0.0
	
	if Input.is_action_pressed("ui_left"):
		horizontal -= 1.0
		player_animation("run")
	elif Input.is_action_pressed("ui_right"):
		horizontal += 1.0
		player_animation("run")
	
	velocity.x = horizontal * move_speed
	
	if Input.is_action_just_pressed("jump"):
		jump()
		
	move_and_slide()
	update_animation()
	
func gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity
	
func jump():
	velocity.y = jump_velocity
		

	
func update_animation():
	if velocity.y == 0: 
		if !animated_sprite_2D.is_playing() or animated_sprite_2D.animation == "jump":
			player_animation("idle")
	elif velocity.y < 0: 
		if animated_sprite_2D.animation != "jump":
			player_animation("jump")
	
			
func player_animation(type):
	animated_sprite_2D.play(type)
