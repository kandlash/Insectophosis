extends "res://scripts/cards/pupue_card.gd"

@export_category("heal hp")
@export var min_hp = 3
@export var max_hp = 5

@export_category("dmg")
@export var min_dmg = 3
@export var max_dmg = 6


func deal_enemy_dmg():
	randomize()
	var random_dmg = randi_range(min_dmg, max_dmg)
	Globals.enemy.hp -= random_dmg
	Globals.game_ui.update_enemy_hp()

func deal_player_heal():
	randomize()
	var random_heal = randi_range(min_hp, max_hp)
	Globals.player.hp -= random_heal
	Globals.game_ui.update_player_hp()
