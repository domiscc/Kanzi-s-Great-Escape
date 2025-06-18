extends Node2D

@onready var player = get_node("/root/game/Player")
@onready var sprite = $AnimatedSprite2D

func _process(_delta):
	sprite.flip_h = player.global_position.x > global_position.x
	
func _on_Hitbox_body_entered(body):
	if body.is_in_group("player"):
		body.take_damage(1)
	
func _ready():
	$Hitbox.body_entered.connect(_on_Hitbox_body_entered)
	

	
