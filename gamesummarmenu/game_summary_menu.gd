extends Panel

@onready var NextLevelButton = $MarginContainer/VBoxContainer/NextLevelButton
@onready var ReturnToMenuButton = $MarginContainer/VBoxContainer/ReturnToMenuButton

@export var demon_points = 500
@export var incorrect_points = -200

var mainMenu = "res://scenes/mainmenu/main_menu.tscn"

func display():
	$AudioStreamPlayer.play()
	get_tree().paused = true
	self.visible = true

func calculateScore(demons_clicked, total_demons, incorrects_clicked):
	var summary = """
	Demons found: %s / %s 
	Demon Bonus: %s 
	Incorrect Penalty: %s 
	Level Bonus : 1000 
	
	Total Points: %s
	"""
	var total = (demons_clicked * demon_points) + 1000  - (incorrects_clicked * incorrect_points)
	var	points = [demons_clicked, total_demons, demons_clicked * demon_points, incorrects_clicked * incorrect_points, total]
	$MarginContainer/VBoxContainer/Summary.text = summary % points

func _on_return_to_menu_button_button_up():
	get_tree().paused = false
	get_tree().change_scene_to_file(mainMenu)
