extends Node2D

@onready var player = get_node("/root/game/Player")
@onready var sprite = $AnimatedSprite2D

func _process(delta):
	sprite.flip_h = player.global_position.x > global_position.x
	
