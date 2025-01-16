extends "res://scripts/cards/pupue_card.gd"


func spiny_explode(is_death):
	if is_death:
		Globals.player.hp -= dmg
		Globals.game_ui.update_player_hp()
		return
	Globals.enemy.hp -= dmg
	Globals.game_ui.update_enemy_hp()


func on_death():
	spiny_explode(true)
