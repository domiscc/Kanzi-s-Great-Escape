extends CharacterBody2D

@export var speed: float = 60.0
var direction := -1  # -1 = left, 1 = right

@onready var wall_right = $Hitbox/WallDetectorRight
@onready var wall_left = $Hitbox/WallDetectorLeft
@onready var ledge_right = $Hitbox/LedgeDetectorRight
@onready var ledge_left = $Hitbox/LedgeDetectorLeft
@onready var sprite = $AnimatedSprite2D

func _physics_process(_delta):
	var should_flip = false

	# Wall detection
	if direction == 1 and wall_right.is_colliding():
		should_flip = true
	elif direction == -1 and wall_left.is_colliding():
		should_flip = true

	# Ledge detection
	if direction == 1 and not ledge_right.is_colliding():
		should_flip = true
	elif direction == -1 and not ledge_left.is_colliding():
		should_flip = true

	# Flip direction
	if should_flip:
		direction *= -1

	# Move and animate
	velocity.x = speed * direction
	move_and_slide()

	sprite.flip_h = direction > 0
	
	
func _ready():
	$Hitbox.body_entered.connect(_on_Hitbox_body_entered)
	
	
func _on_Hitbox_body_entered(body):
	if body.is_in_group("player"):
		body.take_damage(1)
		
