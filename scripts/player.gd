extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

# Constants
const SPEED = 150.0
const JUMP_VELOCITY = -300.0
const WALL_CLIMB_SPEED = -50.0
const MAX_CLIMB_TIME = 1.5

# Variables
var current_health: int = 3
var coin_counter = 0
var climb_time_left: float = MAX_CLIMB_TIME

func _physics_process(delta: float) -> void:
	
	var dir = Input.get_axis("move_left", "move_right")

	# Handle gravity or climbing
	var climbing = false
	if is_on_wall() and dir != 0 and climb_time_left > 0.0:
		velocity.y = WALL_CLIMB_SPEED
		climb_time_left -= delta
		climbing = true
	elif not is_on_floor():
		velocity += get_gravity() * delta

	# Refill climb time when on ground
	if is_on_floor():
		climb_time_left = MAX_CLIMB_TIME

	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Flip the sprite
	if dir > 0:
		animated_sprite.flip_h = false
	elif dir < 0:
		animated_sprite.flip_h = true

	# Play animations
	if is_on_floor():
		if dir == 0:
			animated_sprite.stop()
		else:
			animated_sprite.play("move_right")

	# Horizontal movement
	if dir:
		velocity.x = dir * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("coin"):
		set_coin(coin_counter + 1)
		print(coin_counter)

func set_coin(new_coin_count: int) -> void:
	coin_counter = new_coin_count
