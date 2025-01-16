extends Camera3D

@onready var level_manager := $"../LevelManager"
@onready var player := $"../player"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process_input(false)

func _input(event: InputEvent) -> void:
	# Проверяем, является ли ход игрока
	if not _is_player_turn():
		return

	# Проверяем нажатие на действие "click"
	if not event.is_action_pressed("click"):
		return

	# Проверяем объект, на который указывает луч
	var new_object = shoot_ray()
	if not new_object:
		return
	if not level_manager.selected_card:
		return
	# Обрабатываем карты с эффектами
	if _handle_effect_card(new_object):
		return

	# Проверяем валидность точки назначения и других условий
	if not _can_place_card(new_object):
		return

	# Перемещаем карту
	_place_card(new_object)


func _is_player_turn() -> bool:
	return level_manager.turn_base_manager.game_state == level_manager.turn_base_manager.GameStates.player_turn


func _handle_effect_card(new_object: Object) -> bool:
	if not new_object.is_in_group("cards") or new_object.is_enemy:
		return false
	var card = new_object
	if player.recources - (level_manager.selected_card.price + card.price) < 0:
		return false
	if level_manager.selected_card.is_effect_card:
		var card_to_delete = level_manager.selected_card
		level_manager.selected_card.make_on_card_effect(card)
		var price = level_manager.selected_card.price + card.price
		update_hand(-price)
		card_to_delete.queue_free()
		return true
	return false


func _can_place_card(new_object: Object) -> bool:
	if not new_object.is_in_group("card_point"):
		return false
	if not level_manager.selected_card:
		return false
	if not new_object.is_empty:
		return false
	if player.recources - level_manager.selected_card.price < 0:
		return false
	if level_manager.selected_card.is_effect_card:
		return false
	return true


func _place_card(new_object: Object) -> void:
	level_manager.hand.remove_child(level_manager.selected_card)
	new_object.add_child(level_manager.selected_card)
	
	var tween = create_tween()
	tween.tween_property(
		level_manager.selected_card,
		"global_position",
		new_object.global_position,
		0.25
	).set_trans(Tween.TRANS_SPRING)
	tween.tween_property(
		level_manager.selected_card,
		"global_rotation",
		new_object.global_rotation,
		0.25
	).set_trans(Tween.TRANS_SPRING)
	
	update_hand(-level_manager.selected_card.price)

func update_hand(price):
	player.update_recources(price)
	Globals.game_ui.update_recources()
	level_manager.hand.remove_card(level_manager.selected_card)
	level_manager.unselect_card()	

func shoot_ray():
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_lenght = 100
	var from = project_ray_origin(mouse_pos)
	var to = from + project_ray_normal(mouse_pos) * ray_lenght
	var space = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	var raycast_results = space.intersect_ray(ray_query)
	if not raycast_results.is_empty():
		return raycast_results["collider"]
