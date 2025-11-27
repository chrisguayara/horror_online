extends Node3D

var currentDay = 0
var dayscore = 20
var currScore = 0
func _ready():
	currScore = 0
	currentDay = 1


func dayOne():
	currentDay = 1
	currScore = 0
	
