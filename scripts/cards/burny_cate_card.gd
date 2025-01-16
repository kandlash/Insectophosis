extends "res://scripts/cards/card.gd"

var selfdamage = 1
var is_first_round = true
func update_turn():
	if is_first_round:
		is_first_round = false
		return
	hp -= selfdamage
	if hp == 0:
		queue_free()
	update_hp_label()
