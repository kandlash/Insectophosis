extends "res://scripts/cards/card.gd"

@export_category("hp")
@export var min_hp = 1
@export var max_hp = 5

@export_category("dmg")
@export var min_dmg = 1
@export var max_dmg = 3

func update_turn():
	hp = randi_range(min_hp, max_hp)
	dmg = randi_range(min_dmg, max_dmg)
	update_dmg_label()
	update_hp_label()
