extends Area2D

@onready var timer: Timer = $Timer
var checkpoint_manager
var player

func _ready() -> void:
	checkpoint_manager = get_parent().get_node("CheckpointManager")
	player = get_parent().get_node("Player")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player.take_damage(1)
		
		if player.current_health > 0:
			player.velocity = Vector2.ZERO
			player.global_position = checkpoint_manager.last_location
