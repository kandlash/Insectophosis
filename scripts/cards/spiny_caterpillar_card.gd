extends "res://scripts/cards/card.gd"

func get_damage(dmg: int, card=null):
	super.get_damage(dmg, card)
	if not card:
		return
	card.get_damage(self.dmg)
