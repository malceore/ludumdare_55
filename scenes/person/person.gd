extends Node3D

@export var isTarget = false
@export var isDemon = false
@export var active = true

func _ready():
	$AnimationPlayer.play("Wiggle")

func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	if active and event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		active = false
		get_parent().person_events.emit("clicked", isTarget, isDemon, self)
		summon()
		
func summon():
	$AudioStreamPlayer3D.play()
	$CPUParticles3D.emitting = true
	await get_tree().create_timer(0.5).timeout
	queue_free()
