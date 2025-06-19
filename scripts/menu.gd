extends Control

func _on_start_game_pressed() -> void:
	Singleton.reset_game()  # <-- Reset the game state before starting
	get_tree().change_scene_to_file("res://scenes/lvl1.tscn")

func _on_options_pressed() -> void:
	pass  # You can fill this in later for settings, etc.

func _on_exit_game_pressed() -> void:
	get_tree().quit()
