extends Camera3D

var selected_object
var selected_card

@onready var level_manager := $"../LevelManager"
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		var new_object = shoot_ray()
		if new_object and new_object.name == "card_deck":
			if level_manager.hand.player_hand.size() == 2:
				return
			var new_card = new_object.get_card()
			if not new_card:
				return
			level_manager.hand.add_card(new_card)
			return
		if not new_object or not new_object.is_in_group("cards"):
			if selected_card != null:
				unselect_card()
			return
			
		if new_object.is_in_group("cards"):
			if selected_card and selected_card != new_object:
				unselect_card()
			selected_card = new_object
			if selected_card.is_selected:
				unselect_card()
				return
			selected_card.is_selected = true
			selected_card.make_selected()
			level_manager.selected_card = selected_card

func select_card():
	pass

func unselect_card(animation=true):
	if animation:
		selected_card.make_unselected()
	selected_card.is_selected = false
	selected_card = null
	level_manager.selected_card = null

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
