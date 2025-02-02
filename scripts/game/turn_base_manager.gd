extends Node3D

enum GameStates {
	player_turn,
	enemy_turn
}

var game_state = GameStates.player_turn
@onready var battle_place := $"../battle_place"
@onready var level_manager := $"../LevelManager"
@onready var timer: Timer = $Timer

signal end_turned

func end_turn(by_who):
	level_manager.start_f_cam_transition()
	await level_manager.end_trans
	if by_who == "player":
		battle_place.attack("player")
	elif by_who == "enemy":
		battle_place.attack("enemy")
	await battle_place.end_turn

	if by_who == "enemy":
		timer.start()
		await level_manager.end_trans
	game_state = GameStates.enemy_turn if by_who == "player" else GameStates.player_turn
	if by_who == "enemy":
		Globals.player.reset()
		Globals.game_ui.update_recources()
	end_turned.emit(by_who)


func _on_timer_timeout() -> void:
	level_manager.start_s_cam_transition()
