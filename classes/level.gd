extends Node
class_name level

@export var rotationAmount = 45
@export var zoomAmount = 2
@export var target = 1
@export var nextLevelPath = ""

@onready var map = $Marker3D
@onready var camera = $CameraPivot/Marker3D/Camera3D
@onready var person_handler = $PersonHandler
@onready var game_summary_menu = $GameSummaryMenu

var started = false

func _ready():
	person_handler.person_events.connect(handle_person_event)
	$Summons.Sprite.frame = target
	started = true
	game_summary_menu.NextLevelButton.pressed.connect(loadNextLevel)

func handle_person_event(whatType, isTarget, isDemon, target):
	if whatType == "clicked":
		if isTarget:
			win()
			
func loadNextLevel():
	get_tree().change_scene_to_file(nextLevelPath)

func win():
	game_summary_menu.calculateScore(person_handler.demonsClicked, person_handler.totalDemons, person_handler.incorrectsClicked)
	game_summary_menu.display()

func _input(event):
	if event.is_action_pressed("rotate_left"):
		rotate_left()
	if event.is_action_pressed("rotate_right"):
		rotate_right()		
	if event.is_action_pressed("zoom") and started:
		if camera.position.z == -zoomAmount:
			camera.position.z = 0
		else:
			camera.position.z = -zoomAmount

func rotate_left():
	$CameraPivot.rotate_y(deg_to_rad(rotationAmount))
	
func rotate_right():
	$CameraPivot.rotate_y(deg_to_rad(-rotationAmount))

func view_up():
	$CameraPivot.rotate_x(deg_to_rad(rotationAmount))

func view_down():
	$CameraPivot.rotate_x(deg_to_rad(-rotationAmount))
