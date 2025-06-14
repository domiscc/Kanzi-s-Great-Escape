extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -310.0
var mouseDirection
@export var shouldBeGray = false

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if shouldBeGray:
		$AnimatedSprite2D.get_material().set_shader_parameter("Enabled", true)
	else:
		$AnimatedSprite2D.get_material().set_shader_parameter("Enabled", false)
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	#if Input.is_action_pressed("ein"):
		#get_node("Camera2D/BlackScreen").get_material().set_shader_parameter("value", 1.0)
	#if Input.is_action_pressed("aus"):
		#get_node("Camera2D/BlackScreen").get_material().set_shader_parameter("value", 0.0)
	# Handle jump.
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y=JUMP_VELOCITY
		
	var direction_x:=Input.get_axis("left","right")
	if direction_x != 0:
		$AnimatedSprite2D.flip_h = direction_x < 0
		$AnimatedSprite2D.play("newrun")
		
	if direction_x == 0:
		$AnimatedSprite2D.play("newidle")
		
	velocity.x=direction_x*SPEED
	move_and_slide()
	
