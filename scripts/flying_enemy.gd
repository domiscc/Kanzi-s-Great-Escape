extends CharacterBody2D

@export var speed: float = 70.0
var direction: int = -1  # -1 = left, 1 = right

@onready var wall_right = $Hitbox/WallDetectorRight
@onready var wall_left = $Hitbox/WallDetectorLeft
@onready var sprite = $AnimatedSprite2D

func _physics_process(_delta):
	# Move horizontally
	velocity = Vector2(speed * direction, 0)
	move_and_slide()

	# Flip direction on wall collision
	if direction == -1 and wall_left.is_colliding():
		direction = 1
	elif direction == 1 and wall_right.is_colliding():
		direction = -1

	# Flip sprite to face direction
	sprite.flip_h = direction > 0
	
func _ready():
	$Hitbox.body_entered.connect(_on_Hitbox_body_entered)
	
	
func _on_Hitbox_body_entered(body):
	if body.is_in_group("player"):
		body.take_damage(1)
