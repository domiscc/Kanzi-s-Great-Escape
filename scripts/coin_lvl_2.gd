extends Area2D

var main_scene

func _ready() -> void:
	main_scene = get_parent()
	z_index = 0

func _on_body_entered(_body: CharacterBody2D) -> void:
	main_scene.coin_pickup()
	queue_free()
