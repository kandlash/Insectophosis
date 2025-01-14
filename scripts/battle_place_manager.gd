extends Node3D

@onready var player_card_places = [
	$"../player_place/card_place8/card_point",
	$"../player_place/card_place7/card_point",
	$"../player_place/card_place5/card_point",
	$"../player_place/card_place6/card_point",
]

@onready var enemy_card_places = [
	$"../enemy_place/card_place/card_point",
	$"../enemy_place/card_place2/card_point",
	$"../enemy_place/card_place3/card_point",
	$"../enemy_place/card_place4/card_point",
]


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		make_step()

func make_step():
	for card_place in player_card_places:
		var card = card_place.get_children()[-1]
		if not card.is_in_group("cards"):
			continue
		
		card.attack()
		await card.get_back_ended
		
