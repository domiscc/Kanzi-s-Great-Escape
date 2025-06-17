extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

const SPEED = 150.0
const JUMP_VELOCITY = -300.0
const CLIMB_SPEED = 60.0

var climbing = false

func _physics_process(delta: float) -> void:
	var is_climb_input = Input.is_action_pressed("ui_up")
	var direction = Input.get_axis("ui_left", "ui_right")

	# === Climbing check ===
	if is_on_wall() and is_climb_input:
		climbing = true
	else:
		climbing = false

	# === Apply gravity only if not climbing ===
	if not is_on_floor() and not climbing:
		velocity += get_gravity() * delta

	# === Jumping ===
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# === Climbing movement ===
	if climbing:
		velocity.y = -CLIMB_SPEED  # slow upward movement
	else:
		# no override if not climbing; gravity will apply as normal
		pass

	# === Horizontal movement ===
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# === Flip sprite ===
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	# === Animations ===
	if climbing:
		animated_sprite.play("climb")
	elif is_on_floor():
		if direction == 0:
			animated_sprite.stop()
		else:
			animated_sprite.play("move_right")

	# === Move the character ===
	move_and_slide()
