extends Area2D
var path
func _on_body_entered(_body: Node2D) -> void:
	path = get_path()
	Singleton.lvl1_deleted.append(path)
	Singleton.score_lvl1 += 1
	queue_free()
