extends Area2D

var main_scene

func _ready() -> void:
	main_scene = get_parent()

func _on_body_entered(body: CharacterBody2D) -> void:
	main_scene.smaragd_pickup()
	queue_free()
