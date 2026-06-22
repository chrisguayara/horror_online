extends Node

var dialogActive : bool
var canInteract: bool
var inventoryActive : bool
var nextScene : String

enum State {
	INTRO,
	SHIFT_1,
	SHIFT_2,
	SHIFT_3,
	FINAL
}

var current_state = State.INTRO
 
