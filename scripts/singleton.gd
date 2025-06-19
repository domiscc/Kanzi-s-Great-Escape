extends Node

var counter = 0

var lvl1_deleted = PackedStringArray()

var score_lvl1 = 0
var pos_lvl1 = Vector2(-61.0,-29.0)
var health_lvl1 = 3

var score_lvl2 = 0
var without_lidar_lvl2

func reset_game():
	score_lvl1 = 0
	score_lvl2 = 0
	health_lvl1 = 3
	pos_lvl1 = Vector2(-64, -26)  # Set this to your actual start position
	lvl1_deleted.clear()
