extends Node3D

var f_cam_trans
var s_cam_trans
@onready var player_head_camera = $"../player_head_camera"
@onready var table_topdown_camera = $"../table_topdown_camera"

func _ready() -> void:
	f_cam_trans = player_head_camera.transform
	s_cam_trans = table_topdown_camera.transform
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("1cam"):
		start_s_cam_transition()
		
	if event.is_action_pressed("2cam"):
		start_f_cam_transition()

func start_s_cam_transition():
	var tween = create_tween()
	tween.tween_property(
		table_topdown_camera,
		"transform",
		f_cam_trans,
		0.25
		).set_trans(Tween.TRANS_SPRING)
	tween.tween_callback(finish_s_cam_transition)


func start_f_cam_transition():
	var tween = create_tween()
	tween.tween_property(
		player_head_camera,
		"transform",
		s_cam_trans,
		0.25
		).set_trans(Tween.TRANS_SPRING)
	tween.tween_callback(finish_f_cam_transition)

func finish_f_cam_transition():
	player_head_camera.transform = f_cam_trans
	table_topdown_camera.current = true
	player_head_camera.current = false

func finish_s_cam_transition():
	table_topdown_camera.transform = s_cam_trans
	player_head_camera.current = true
	table_topdown_camera.current = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
