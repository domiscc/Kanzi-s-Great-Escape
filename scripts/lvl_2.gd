extends Node2D

var isNearScanner = false
var score
var pos_lvl1 = Vector2(-668.0,-252.0)
#var pos_lvl1 = Vector2(3050.0,-632.0)
@export var timer_label : Label

var stopwatch : Stopwatch

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stopwatch = get_tree().get_first_node_in_group("stopwatch")
	score = 0
	Singleton.score_lvl2 = score
	get_node("Icon").get_material().set_shader_parameter("value", 1.0)
	get_node("Icon2").get_material().set_shader_parameter("value", 1.0)
	get_node("Icon3").get_material().set_shader_parameter("value", 1.0)
	get_node("Icon4").get_material().set_shader_parameter("value", 1.0)
	get_node("Icon5").get_material().set_shader_parameter("value", 1.0)
	get_node("Icon6").get_material().set_shader_parameter("value", 1.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$CanvasLayer/VBoxContainer/Score.text = "Score: " + str(score)
	update_stopwatch_label()
	#if Input.is_action_pressed("ein"):
		#get_node("Icon").get_material().set_shader_parameter("value", 1.0)
		#get_node("Icon2").get_material().set_shader_parameter("value", 1.0)
		#get_node("Icon3").get_material().set_shader_parameter("value", 1.0)
		#get_node("Icon4").get_material().set_shader_parameter("value", 1.0)
		#get_node("Icon5").get_material().set_shader_parameter("value", 1.0)
		#get_node("Icon6").get_material().set_shader_parameter("value", 1.0)
	#if Input.is_action_pressed("aus"):
		#get_node("Icon").get_material().set_shader_parameter("value", 0.0)
		#get_node("Icon2").get_material().set_shader_parameter("value", 0.0)
		#get_node("Icon3").get_material().set_shader_parameter("value", 0.0)
		#get_node("Icon4").get_material().set_shader_parameter("value", 0.0)
		#get_node("Icon5").get_material().set_shader_parameter("value", 0.0)
		#get_node("Icon6").get_material().set_shader_parameter("value", 0.0)
	if isNearScanner:
		if Input.is_action_pressed("actualinteract"):
			$LidarPickup.queue_free()
			$player_lvl_2/lidar_gun_lvl_2.isPickedUp = true
			$CanvasLayer/PickupMessage.visible = false
	

func _on_lidar_pickup_body_entered(_body: CharacterBody2D) -> void:
	$CanvasLayer/PickupMessage.visible = true
	isNearScanner = true


func _on_lidar_pickup_body_exited(_body: CharacterBody2D) -> void:
	$CanvasLayer/PickupMessage.visible = false
	isNearScanner = false


func _on_start_area_body_entered(_body: CharacterBody2D) -> void:
	$player_lvl_2.shouldBeGray = false


func _on_start_area_body_exited(_body: CharacterBody2D) -> void:
	$player_lvl_2.shouldBeGray = true


func _on_end_area_body_entered(_body: CharacterBody2D) -> void:
	$player_lvl_2.shouldBeGray = false


func _on_end_area_body_exited(_body: CharacterBody2D) -> void:
	$player_lvl_2.shouldBeGray = true

func coin_pickup():
	score += 1
	
func smaragd_pickup():
	score += 2


func _on_level_end_body_entered(_body: CharacterBody2D) -> void:
	Singleton.pos_lvl1 = pos_lvl1
	Singleton.score_lvl2 = score
	stopwatch.stopped = true
	Singleton.time_lvl2 = stopwatch.time
	if !$player_lvl_2/lidar_gun_lvl_2.isPickedUp:
		Singleton.without_lidar_lvl2 = true
	call_deferred("_change_to_lvl1")

func _change_to_lvl1() -> void:
	get_tree().change_scene_to_file("res://scenes/lvl1.tscn")

func update_stopwatch_label():
	timer_label.text = stopwatch.time_to_string()
