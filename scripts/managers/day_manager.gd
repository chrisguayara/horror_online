extends Node3D

var currentDay := 0

var currGoal := {
	"rabbit": 2,
	"duck": 1,
	"raccoon": 0,
	"deer": 0,
}

var currKills := {
	"rabbit": 0,
	"duck": 0,
	"raccoon": 0,
	"deer": 0
}

func _ready():
	currentDay = 1


func startDay(day: int):
	currentDay = day
	
	currKills = {
		"rabbit": 0,
		"duck": 0,
		"raccoon": 0,
		"deer": 0
	}


func checkStats() -> bool:
	var verified := 0
	
	for anim in currGoal.keys():
		if currKills.get(anim, 0) >= currGoal.get(anim, 0):
			verified += 1
	
	return verified == currGoal.size()


func addTrophy(enemy: String):
	if enemy in currGoal:
		currKills[enemy] += 1


func _on_enemy_death(enemy_name: String):
	addTrophy(enemy_name)
	if checkStats():
		print("Goal met! Return to the cabin.")
