extends "res://scripts/cards/card.gd"

func attack(is_enemy):
	get_back()

func metamorphose():
	super.metamorphose()
	on_success_meta()

func on_success_meta():
	pass

func death():
	super.death()
	on_death()

func on_death():
	pass
