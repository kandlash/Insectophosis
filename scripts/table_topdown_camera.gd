extends Camera3D

@onready var level_manager := $"../LevelManager"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process_input(false)

func _input(event: InputEvent) -> void:
	if level_manager.turn_base_manager.game_state != level_manager.turn_base_manager.GameStates.player_turn:
		return
	if event.is_action_pressed("click"):
		var new_object = shoot_ray()
		if not new_object:
			return
		if not new_object.is_in_group("card_point"):
			return
		if not level_manager.selected_card:
			return
		print(new_object)
		print(new_object.is_empty)
		if not new_object.is_empty:
			return
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
