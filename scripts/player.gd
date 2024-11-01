extends CharacterBody2D

const acceleration = 50
const friction = 70

@export var slow_time_scale = 0.1
@export var arrow_duration = 0.5
@export var lunge_duration = 0.3

@onready var lunge_animation = load("res://scenes/lunge_animation.tscn")
@onready var arrow = $Arrow
@onready var animated_sprite_2D = $AnimatedSprite2D
@onready var max_jumps = 1
@onready var jump_timer: Timer
@onready var lunge_timer: Timer
@onready var lunge_active = false

@export var lunge_direction = Vector2.ZERO
@export var lunge_speed = 400
@export var move_speed = 150
@export var jump_height : float
@export var jump_time_to_peak: float
@export var jump_time_to_descent: float


@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1
@onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1
@onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1


func _ready() -> void:
	var velocity := Vector2.ZERO
	animated_sprite_2D.play("idle")
	
	jump_timer = Timer.new()
	jump_timer.one_shot = true
	add_child(jump_timer)
	lunge_timer = Timer.new()
	lunge_timer.one_shot = true
	add_child(lunge_timer)
	
	
func _physics_process(delta):
	velocity.y += gravity() * delta
	var horizontal := 0.0
	if !lunge_active:
		if Input.is_action_pressed("ui_left"):
			horizontal -= 1.0
			player_animation("run")
		elif Input.is_action_pressed("ui_right"):
			horizontal += 1.0
			player_animation("run")
		else:
			player_animation("idle")
	
		velocity.x = horizontal * move_speed
	
	if is_on_floor():
		lunge_active = false
		reset_jumps()
		reset_time()
	
	if Input.is_action_just_pressed("jump"):
		jump()
		
	
	if jump_timer.is_stopped():
		reset_time()
		
	move_and_slide()
	update_animation()

func gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity
	
func jump():
	if max_jumps == 1 and Engine.time_scale == 1:
		max_jumps -= 1
		velocity.y = jump_velocity
	elif max_jumps == 0:
		max_jumps -= 1
		slow_time()
		lunge_active = true
	elif max_jumps == -1:
		max_jumps -= 1
		lunge_towards_arrow()
		particle_animation()
		stop_double_jump()
		
func reset_jumps():
	max_jumps = 1
	
func slow_time():
	Engine.time_scale = slow_time_scale
	arrow.visible = true
	jump_timer.start(arrow_duration)
	
func stop_double_jump():
	jump_timer.stop()
	reset_time()
	
func lunge_towards_arrow():
	var angle = arrow.global_rotation
	var lunge_direction = Vector2.UP.rotated(angle)
	velocity += lunge_direction * lunge_speed
	lunge_timer.start(lunge_duration)
	print(velocity)
	
func reset_time():
	Engine.time_scale = 1.0
	arrow.visible = false
	await lunge_timer.timeout
	lunge_active = false

	
func update_animation():
	if is_on_floor(): 
		if !animated_sprite_2D.is_playing() or animated_sprite_2D.animation == "jump":
			player_animation("idle")
	else: 
		if animated_sprite_2D.animation != "jump":
			player_animation("jump")
	
			
func player_animation(type):
	animated_sprite_2D.play(type)
	
func particle_animation():
	var animation_node = lunge_animation.instantiate()
	get_tree().root.add_child(animation_node)
	var animation = animation_node.get_node("AnimatedSprite2D")
	animation_node.global_position = self.global_position
	animation_node.rotation = arrow.rotation - (PI / 2)
	animation.play("play")
	
	
	
	
	
	
	
