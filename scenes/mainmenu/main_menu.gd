extends Node3D

var level = [
	"",
	"res://scenes/levels/level_1/level.tscn",
	"res://scenes/levels/level_2/level.tscn",
	"res://scenes/levels/level_3/level.tscn"
]

func _on_button_level_1_button_up():
	get_tree().change_scene_to_file(level[1])

func _on_button_level_2_button_up():
	get_tree().change_scene_to_file(level[2])

func _on_button_level_3_pressed():
	get_tree().change_scene_to_file(level[3])
