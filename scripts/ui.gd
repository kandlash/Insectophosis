extends CanvasLayer

@onready var player := $"../player"
@onready var enemy := $"../enemy"
@onready var recources_label := $recources_label
@onready var player_hp_label := $player_hp_label
@onready var enemy_hp_label := $enemy_hp_label

func _ready() -> void:
	Globals.set_game_ui(self)
	update_recources()
	update_enemy_hp()
	update_player_hp()
	
func update_recources():
	recources_label.text = "recources: " + str(player.recources)

func update_enemy_hp():
	enemy_hp_label.text = "enemy_hp: " + str(enemy.hp)
	
func update_player_hp():
	player_hp_label.text = "player_hp: " + str(player.hp)
