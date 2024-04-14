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
@onready var spotlight = $Marker3D/Spotlight

var started = false
var zoomed = false
var target_rotation = 0

func _ready():
	get_tree().paused = false
	person_handler.person_events.connect(handle_person_event)
	$Summons.Sprite.frame = target
	started = true
	if nextLevelPath != "":
		game_summary_menu.NextLevelButton.pressed.connect(loadNextLevel)
	else:
		game_summary_menu.NextLevelButton.visible = false
		
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
	if event is InputEventMouseMotion:
		if !zoomed:
			spotlight.visible = true
			var mousePos = get_mouse_coordinates()
			if mousePos.size() > 0:
				spotlight.global_position.x = mousePos.position.x
				spotlight.global_position.z = mousePos.position.z
		else:
			spotlight.visible = false

	if zoomed and event is InputEventMouseMotion:
#		camera.rotate_y(deg_to_rad(event.relative.y * zoomed_mouse_sen))
		var mousePos = get_mouse_coordinates()
		if mousePos.size() > 0:
			$CameraPivot.position.x = mousePos.position.x 
			$CameraPivot.position.z = mousePos.position.z
	if event.is_action_pressed("zoom") and started:
		if zoomed:
			$CameraPivot.position = Vector3.ZERO
			camera.position = Vector3.ZERO
			camera.rotation = Vector3.ZERO
			zoomed = false
		else:
			var mousePos = get_mouse_coordinates()
#			print_debug(mousePos, zoomed)
			zoomed = true
			if mousePos.size() > 0:
				camera.position.z = -zoomAmount
				$CameraPivot.global_position.x = mousePos.position.x
				$CameraPivot.global_position.z = mousePos.position.z

func _process(delta):
	if Input.is_action_just_pressed("rotate_right"):
		target_rotation += rotationAmount
	if Input.is_action_just_pressed("rotate_left"):
		target_rotation -= rotationAmount
	$CameraPivot.rotation.y = lerp_angle($CameraPivot.rotation.y, deg_to_rad(target_rotation), 0.12)

func get_mouse_coordinates():
	var space_state = get_world_3d().direct_space_state
	var mousepos = get_viewport().get_mouse_position()
	# Adding an offset because for some reason the mouse cursor output is off.
	mousepos -= Vector2(-10, 150)

	var origin = camera.project_ray_origin(mousepos)
	var end = origin + camera.project_ray_normal(mousepos) * 100
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collision_mask = 2
	return space_state.intersect_ray(query)



