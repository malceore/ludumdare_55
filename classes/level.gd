extends Node
class_name level

@export var rotationAmount = 45
@export var zoomAmount = 1.8
@export var zoom_mouse_sen = 0.2
@export var target = 1
@export var nextLevelPath = ""

@onready var map = $Marker3D
@onready var camera = $CameraPivot/Marker3D/Camera3D
@onready var person_handler = $PersonHandler
@onready var game_summary_menu = $GameSummaryMenu

var started = false
var zoomed = false

func _ready():
	get_tree().paused = false
	person_handler.person_events.connect(handle_person_event)
	$Summons.Sprite.frame = target
	started = true
	game_summary_menu.NextLevelButton.pressed.connect(loadNextLevel)

func handle_person_event(whatType, isTarget, isDemon, target):
	if whatType == "clicked":
		if isTarget:
			win()
			
func loadNextLevel():
	get_tree().paused = false
	get_tree().change_scene_to_file(nextLevelPath)

func win():
	game_summary_menu.calculateScore(person_handler.demonsClicked, person_handler.totalDemons, person_handler.incorrectsClicked)
	game_summary_menu.display()

func _input(event):
	if zoomed and event is InputEventMouseMotion:
		var camera_anglev = 0
		camera.rotate_y(deg_to_rad(-event.relative.x*zoom_mouse_sen))
		var changev = -event.relative.y * zoom_mouse_sen
		camera_anglev += changev
		camera.rotate_x(deg_to_rad(changev))
	if event.is_action_pressed("rotate_left"):
		rotate_left()
	if event.is_action_pressed("rotate_right"):
		rotate_right()		
	if event.is_action_pressed("zoom") and started:
		if zoomed:
			camera.position.z = 0
			camera.rotation = Vector3(0,0,0)
			zoomed = false
		else:
			camera.position.z = -zoomAmount
			zoomed = true

func rotate_left():
	$CameraPivot.rotate_y(deg_to_rad(rotationAmount))
	
func rotate_right():
	$CameraPivot.rotate_y(deg_to_rad(-rotationAmount))

func view_up():
	$CameraPivot.rotate_x(deg_to_rad(rotationAmount))

func view_down():
	$CameraPivot.rotate_x(deg_to_rad(-rotationAmount))
