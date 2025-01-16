extends "res://scripts/cards/pupue_card.gd"

func burny_explode(is_death):
	if is_death:
		deal_cards_damage(Globals.player_places)
	else:
		deal_cards_damage(Globals.enemy_places)

func deal_cards_damage(places):
	for place in places:
		var card = place.get_children()[-1]
		if not card.is_in_group("cards") or card == self:
			continue
		card.get_damage(dmg)

func on_death():
	burny_explode(true)
