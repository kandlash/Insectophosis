extends Node3D

var player_hand = []
@export var card_scene : PackedScene
const CARD_OFFSET = 0.8
var hand_max = 4
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_down"):
		add_card_to_hand()
	if event.is_action_pressed("ui_accept"):
		if player_hand.is_empty():
			return
		player_hand.pop_back().queue_free()
		update_card_positions()

func add_card_to_hand():
	var card = card_scene.instantiate()
	player_hand.append(card)
	add_child(card)
	update_card_positions()

func add_card(card):
	player_hand.append(card)
	add_child(card)
	update_card_positions()

func remove_card(card):
	player_hand.erase(card)
	update_card_positions()
	
	
func update_card_positions():
	var num_cards = player_hand.size()
	if num_cards == 0:
		return

	var center_offset = (num_cards - 1) * CARD_OFFSET * 0.5

	for i in range(num_cards):
		var card = player_hand[i]
		var offset = (i * CARD_OFFSET) - center_offset
		var new_position = Vector3(position.x, position.y, position.z + offset)
		var tween = create_tween()
		tween.tween_property(card,
		 "position",
		 new_position,
		 0.15).set_trans(Tween.TRANS_SPRING)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
