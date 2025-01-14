extends Node3D

@export
var enemy_cards = [PackedScene]

var enemy_places = []
var enemy_hand = 2
var enemy_resources = 2
@onready var turn_base_manager := $"../TurnBaseManager"
@onready var battle_place := $"../battle_place"

func _ready() -> void:
	turn_base_manager.connect("end_turned", _on_end_turned)
	enemy_places = battle_place.get_enemy_places()

func enemy_turn():
	var cards = []
	for i in range(0, enemy_hand):
		cards.append(enemy_cards.pick_random())
	place_card(cards)
	enemy_resources = 2
	
	turn_base_manager.end_turn("enemy")

func place_card(cards: Array):
	if cards.is_empty():
		return
	var empty_places : Array
	for place in enemy_places:
		if place.is_empty:
			empty_places.append(place)
	if empty_places.is_empty():
		return
	var card_ = get_strongest(cards)
	print(cards)
	var card = card_.instantiate()
	if enemy_resources - card.price < 0:
		return
	enemy_resources -= card.price
	var place = empty_places.pick_random()
	place.add_child(card)
	card.global_position = place.global_position
	place_card(cards)
		
func get_strongest(cards: Array):
	#to do
	var card = cards.pick_random()
	cards.erase(card)
	return card

func _on_end_turned(by_who):
	if by_who == "player":
		enemy_turn()
