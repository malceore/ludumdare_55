extends Node
class_name level

@export var rotationAmount = 45
@export var zoomAmount = 2

@onready var map = $Marker3D
@onready var camera = $CameraPivot/Marker3D/Camera3D

var started = false

func _input(event):
	if event.is_action_pressed("rotate_left"):
		rotate_left()
	if event.is_action_pressed("rotate_right"):
		rotate_right()		
#	if event.is_action_pressed("view_up"):
#		view_up()
#	if event.is_action_pressed("view_down"):
#		view_down()
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

func _ready():
	started = true
