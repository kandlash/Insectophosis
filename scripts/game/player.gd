extends Node3D


var recources = 10
var cards_per_round = 10
var hp = 20

func _ready() -> void:
	Globals.set_player(self)
	
func update_recources(value):
	recources += value

func update_cards(value):
	cards_per_round += value
	
func reset():
	recources = 5
	cards_per_round = 5
