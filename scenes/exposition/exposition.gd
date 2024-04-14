extends Panel

@onready var dialogBox = $MarginContainer/VBoxContainer/Dialog
var currentDialog = 0 
var dialog = [
"Welcome to your first day of public service.",
"From today forward you will serve summons for the court of Hell.",
"Seek out your target and notify them, they will then be instantly summoned for processing.",
"Be careful, if you summon the incorrect target they will be trapped in hell.",
"But more importantly your pay will be docked.",
"Last thing, if you see any other demons up on the surface send them back down here for a bonus."
]


func _process(delta):
	if Input.is_action_just_pressed("zoom"):
		next_text()

func _ready():
	next_text()

func next_text():
	$MarginContainer/VBoxContainer/Sprite2D/AnimationPlayer.play("talk")
	if currentDialog < dialog.size():
		dialogBox.text = dialog[currentDialog]
		currentDialog += 1
	else:
		get_tree().change_scene_to_file("res://scenes/levels/level_1/level.tscn")

func _on_button_pressed():
	next_text()
