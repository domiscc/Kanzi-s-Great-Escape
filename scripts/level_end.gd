extends Area2D

var main_scene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_scene = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		call_deferred("end_level")  # Delay the scene change until it's safe

func end_level():
	main_scene.end()
	get_tree().change_scene_to_file("res://scenes/score_board.tscn")
	
