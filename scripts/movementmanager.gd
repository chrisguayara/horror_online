extends Node

var blcked_count = 0

signal movement_blocked()
signal movement_unblocked()

func block_movement():
	blcked_count += 1
	if blcked_count == 1:
		emit_signal("movement_blocked")

func unblock_movement():
	blcked_count = max(blcked_count - 1, 0)
	if blcked_count == 0:
		emit_signal("movement_unblocked")

func can_move() -> bool:
	return blcked_count == 0
