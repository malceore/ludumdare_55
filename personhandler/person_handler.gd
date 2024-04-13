extends Node3D

signal person_events 

var demonsClicked = 0
var incorrectsClicked = 0
var targetsClicked = 0
var totalDemons = 0


func _ready():
	person_events.connect(handle_person_event)
	for child in get_children():
		if child.isDemon:
			totalDemons += 1

func handle_person_event(whatType, isTarget, isDemon, target):
	if whatType == "clicked":
		if isDemon:
			demonsClicked += 1
		if isTarget:
			targetsClicked += 1
		else:
			incorrectsClicked += 1
