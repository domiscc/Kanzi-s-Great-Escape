extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		end_level()
		
		
func end_level():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")  # Replace with your next scene

	
