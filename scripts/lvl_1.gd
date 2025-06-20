extends Node2D

var start_pos = Vector2(-61.0,-29.0)
var start_time = 0.0
#var path
#var actualPath
#var dont = false
var delete
@export var timer_label : Label

var stopwatch : Stopwatch

func _ready() -> void:
	stopwatch = get_tree().get_first_node_in_group("stopwatch")
	$Player.position = Singleton.pos_lvl1
	Singleton.pos_lvl1 = start_pos
	stopwatch.time = Singleton.time_lvl1
	Singleton.time_lvl1 = start_time
	#actualPath = get_path_to($Coins/Coin)
	for i in range(Singleton.lvl1_deleted.size()):
		delete = get_node(Singleton.lvl1_deleted.get(i))
		delete.queue_free()

func _process(_delta: float) -> void:
	update_stopwatch_label()
	#if Input.is_action_pressed("test") and !dont:
		#print(Singleton.score_lvl1)
		#print(Singleton.lvl1_deleted)
		#
		#dont = true
		#path = get_node(actualPath)
		#path.queue_free()
	

func _on_transition_area_body_entered(_body: Node2D) -> void:
	Singleton.health_lvl1 = $Player.current_health
	Singleton.time_lvl1 = stopwatch.time
	call_deferred("load_next_level")

func load_next_level():
	get_tree().change_scene_to_file("res://scenes/lvl_2.tscn")

func update_stopwatch_label():
	timer_label.text = stopwatch.time_to_string()

func end():
	Singleton.time_lvl1 = stopwatch.time
