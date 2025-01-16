extends Node3D

@onready var player_card_places = [
	$"player_place/card_place8/card_point",
	$"player_place/card_place7/card_point",
	$"player_place/card_place5/card_point",
	$"player_place/card_place6/card_point",
]

@onready var enemy_card_places = [
	$"enemy_place/card_place3/card_point",
	$"enemy_place/card_place2/card_point",
	$"enemy_place/card_place/card_point",
	$"enemy_place/card_place4/card_point",
]

signal end_turn

func get_enemy_places():
	return enemy_card_places

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		make_step(player_card_places, false)
	if event.is_action_pressed("enemy_attack"):
		make_step(enemy_card_places, true)

func attack(by_who):
	if by_who == "player":
		make_step(player_card_places, false)
	else:
		make_step(enemy_card_places, true)

func make_step(places, is_enemy):
	print('no cards')
	for card_place in places:
		var card = card_place.get_children()[-1]
		if not card.is_in_group("cards"):
			continue
		card.attack(is_enemy)
		await card.get_back_ended
	print('nani nani')
	end_turn.emit()
		
