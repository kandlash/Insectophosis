extends Node3D

@export var cards = {}

func get_card():
	var keys_list = cards.keys()
	var random_key = keys_list.pick_random()
	if not random_key:
		return
	if cards.get(random_key) - 1 < 0:
		return
	var new_card = random_key.instantiate()
	add_child(new_card)
	new_card.position = position
	remove_child(new_card)
	cards[random_key] = cards.get(random_key) - 1
	return new_card
