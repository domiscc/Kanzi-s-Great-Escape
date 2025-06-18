extends CharacterBody2D

# Imports
@onready var animated_sprite = $AnimatedSprite2D
@onready var score = get_node("/root/game/CanvasLayer/ScoreContainer/Score")
@onready var heart_1 = get_node("/root/game/CanvasLayer/Hearts/Heart1")
@onready var heart_2 = get_node("/root/game/CanvasLayer/Hearts/Heart2")
@onready var heart_3 = get_node("/root/game/CanvasLayer/Hearts/Heart3")

# Physics
const SPEED = 150.0
const JUMP_VELOCITY = -300.0

# Checkoints
var respawn_position: Vector2

# Climbing
const WALL_CLIMB_SPEED = -50.0
var climbing = false
var max_climb_time = 1.5
var climb_time_left: float = max_climb_time

# Health
const MAX_HEALTH = 3
var current_health: int = 3

# Score
var coin_counter = 0

func _physics_process(delta: float) -> void:
	
	var dir = Input.get_axis("move_left", "move_right")

	# Handle gravity or climbing
	if is_on_wall() and dir != 0 and climb_time_left > 0.0:
		velocity.y = WALL_CLIMB_SPEED
		climb_time_left -= delta
		climbing = true
	elif not is_on_floor():
		velocity += get_gravity() * delta

	# Refill climb time when on ground
	if is_on_floor():
		climb_time_left = max_climb_time

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
	
	
func heal(amount: int) -> void:
	if current_health < MAX_HEALTH:
		current_health = min(current_health + amount, MAX_HEALTH)
		update_hearts()
		flash_green()
	
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("coin"):
		set_coin(coin_counter + 1)
		
		
func set_coin(new_coin_count: int) -> void:
	var previous_coin_count = coin_counter
	coin_counter = new_coin_count
	score.text = "Score: %d" % coin_counter

	# Heal 1 heart every 5 coins
	if int(coin_counter / 5) > int(previous_coin_count / 5):
		heal(1)

	# Climb boost at 15 coins
	if coin_counter >= 15 and max_climb_time < 2.0:
		max_climb_time = 2.0
		
		
func flash_green():
	var tween = create_tween()
	tween.tween_property(animated_sprite, "modulate", Color(0, 1, 0), 0.2)
	tween.tween_property(animated_sprite, "modulate", Color(1, 1, 1), 0.2)
		
		
func flash_red():
	var tween = create_tween()
	tween.tween_property(animated_sprite, "modulate", Color(1, 0, 0), 0.2)
	tween.tween_property(animated_sprite, "modulate", Color(1, 1, 1), 0.2)
	
	
func shake_camera(strength := 10.0, duration := 0.2):
	var camera = $Camera2D
	var tween = create_tween()
	
	# Random offset shake
	for i in range(5):
		var offset = Vector2(
			randf_range(-strength, strength),
			randf_range(-strength, strength)
		)
		tween.tween_property(camera, "offset", offset, duration / 5)
	
	tween.tween_property(camera, "offset", Vector2.ZERO, 0.05)
	
	
func update_hearts():
	var hearts = [heart_1, heart_2, heart_3]
	for i in range(MAX_HEALTH):
		if i < current_health:
			hearts[i].texture = preload("res://assets/Hearts/FullHeart.png")
		else:
			hearts[i].texture = preload("res://assets/Hearts/EmptyHeart.png")
			
			
func reload_scene():
	get_tree().reload_current_scene()
			
			
func take_damage(amount: int) -> void:
	current_health = max(0, current_health - amount)
	update_hearts()
	flash_red()
	shake_camera()

	if current_health == 0:
		call_deferred("reload_scene")
		
		
func _on_checkpoint_body_entered(body):
	if body == self:
		respawn_position = global_position
		print("Checkpoint reached at:", respawn_position)
