extends Node2D

var start_pos = Vector2(-61.0,-29.0)
#var path
#var actualPath
#var dont = false
var delete

func _ready() -> void:
	$Player.position = Singleton.pos_lvl1
	Singleton.pos_lvl1 = start_pos
	#actualPath = get_path_to($Coins/Coin)
	for i in range(Singleton.lvl1_deleted.size()):
		delete = get_node(Singleton.lvl1_deleted.get(i))
		delete.queue_free()

func _process(_delta: float) -> void:
	#if Input.is_action_pressed("test") and !dont:
		#print(Singleton.score_lvl1)
		#print(Singleton.lvl1_deleted)
		#
		#dont = true
		#path = get_node(actualPath)
		#path.queue_free()
	pass

func _on_transition_area_body_entered(_body: Node2D) -> void:
	Singleton.health_lvl1 = $Player.current_health
	get_tree().change_scene_to_file("res://scenes/lvl_2.tscn")
