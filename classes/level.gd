extends Node3D
class_name level

@export var rotationAmount = 45
@export var zoomAmount = 1.8
@export var zoomed_mouse_sen = 0.2
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
	$AudioStreamPlayer.loop = true
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
#	if zoomed and event is InputEventMouseMotion:
#		camera.rotate_y(deg_to_rad(-event.relative.x * zoomed_mouse_sen))
#		var mousePos = get_mouse_coordinates()
#		if mousePos.size() > 0:
#			$CameraPivot.position.x = mousePos.position.x
#			$CameraPivot.position.y = mousePos.position.y
	if event.is_action_pressed("rotate_left"):
		rotate_left()
	if event.is_action_pressed("rotate_right"):
		rotate_right()		
	if event.is_action_pressed("zoom") and started:
		if zoomed:
			$CameraPivot.position = Vector3.ZERO
			camera.position = Vector3.ZERO
			camera.rotation = Vector3.ZERO
			zoomed = false
		else:
			var mousePos = get_mouse_coordinates()
			print_debug(mousePos, zoomed)
			zoomed = true
			if mousePos.size() > 0:
				camera.position.z = -zoomAmount
				$CameraPivot.position.x = mousePos.position.x
				$CameraPivot.position.y = mousePos.position.y


func get_mouse_coordinates():
	var space_state = get_world_3d().direct_space_state
	var cam = camera
	var mousepos = get_viewport().get_mouse_position()

	var origin = cam.project_ray_origin(mousepos)
	var end = origin + cam.project_ray_normal(mousepos) * 100
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true
	# This is the collision of the ground only.
	query.collision_mask = 2
	return space_state.intersect_ray(query)


func rotate_left():
	$CameraPivot.rotate_y(deg_to_rad(rotationAmount))
	
func rotate_right():
	$CameraPivot.rotate_y(deg_to_rad(-rotationAmount))

func view_up():
	$CameraPivot.rotate_x(deg_to_rad(rotationAmount))

func view_down():
	$CameraPivot.rotate_x(deg_to_rad(-rotationAmount))
