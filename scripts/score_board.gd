extends Control

var num = 0
var ref
var path

func _ready() -> void:
	$VBoxContainer/HBoxContainer/Level1/Score.text = "Score: " + str(Singleton.score_lvl1)
	$VBoxContainer/HBoxContainer/Level1/Time.text = "Time: " + time_to_string(Singleton.time_lvl1)
	$VBoxContainer/HBoxContainer/Level2/Score.text = "Score: " + str(Singleton.score_lvl2)
	$VBoxContainer/HBoxContainer/Level2/Time.text = "Time: " + time_to_string(Singleton.time_lvl2)
	num = convert_score_to_num_of_bananas(Singleton.score_lvl1 + Singleton.score_lvl2)
	$VBoxContainer/Gesamtscore.text = "Total Score: " + str(Singleton.score_lvl1 + Singleton.score_lvl2)
	#$VBoxContainer/text.text = "Your score amounts to the following amount of bananas. Congratulations!" 
	for i in range(0,num):
		path = "VBoxContainer/Bananascore/TextureRect" + str(i+1)
		ref = get_node(path)
		ref.visible = true

func convert_score_to_num_of_bananas(score) -> int:
	if (score<60):
		num = 1
	elif (score<69):
		num = 2
	elif (score<79):
		num = 3
	elif (score<89):
		num = 4
	else:
		num = 5
	return num

func time_to_string(time: float) -> String:
	var msec = fmod(time, 1) * 1000
	var sec = fmod(time, 60)
	var min = time / 60
	var format_string = "%02d : %02d : %02d"
	var actual_string = format_string % [min, sec, msec]
	return actual_string


func _on_back_to_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
