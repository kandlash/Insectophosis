extends "res://scripts/cards/effect_card.gd"

@export var dmg_buff : int = 1

func make_on_card_effect(card):
	card.dmg += dmg_buff
	card.update_dmg_label()
