extends Node3D

@export var rotationSpeed = 0.004

var level = [
	"res://scenes/exposition/exposition.tscn",
	"res://scenes/levels/level_1/level.tscn",
	"res://scenes/levels/level_2/level.tscn",
	"res://scenes/levels/level_3/level.tscn",
	"res://scenes/levels/level_4/level.tscn",
	"res://scenes/levels/level_5/level.tscn",
	"res://scenes/levels/level_6/level.tscn",
	"res://scenes/levels/level_7/level.tscn",
	"res://scenes/levels/level_8/level.tscn",
	"res://scenes/levels/level_9/level.tscn"
]

func _process(delta):
	$CameraPivot.rotate_y(rotationSpeed)

func load_level(level):
	$AudioGavel.play()
	await $AudioGavel.finished
	get_tree().change_scene_to_file(level)

func _on_button_level_1_button_up():
	load_level(level[0])

func _on_button_level_2_button_up():
	load_level(level[2])

func _on_button_level_3_pressed():
	load_level(level[3])

func _on_button_level_7_pressed():
	load_level(level[7])

func _on_button_level_8_pressed():
	load_level(level[8])

func _on_button_level_9_pressed():
	load_level(level[9])

func _on_button_level_4_pressed():
	load_level(level[4])

func _on_button_level_5_pressed():
	load_level(level[5])

func _on_button_level_6_pressed():
	load_level(level[0])
