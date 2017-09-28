extends Node2D

onready var player = globals.player.instance()
onready var platform = globals.platform

var pause_state = [false, true]

func stage_pause():
	if pause_state[1]:
		pause_state[1] = false
		pause_state[0] = not pause_state[0]
		get_tree().set_pause(pause_state[0])

func create_platform(pos):
	var new_platform = platform.instance()

	new_platform.set_pos(pos)
	player.connect("platform_on_land", new_platform, "collision_handler")
	add_child(new_platform)

	return new_platform

func input_handler():
	if globals.action.ui_accept and pause_state[1]:
		stage_pause()
	if not (globals.action.ui_accept or pause_state[1]):
		pause_state[1] = true

func _fixed_process(d):
	input_handler()

	if player.get_pos().x < 0:
		player.set_pos(Vector2(globals.viewport.x, player.get_pos().y))
	elif player.get_pos().x > globals.viewport.x:
		player.set_pos(Vector2(0, player.get_pos().y))
	if player.get_pos().y > globals.viewport.y:
		player.speed = 0
		player.set_linear_velocity(Vector2(0, 0))
		player.set_pos(globals.viewport*Vector2(0.5, 0.2))

func _ready():
	create_platform(globals.viewport*Vector2(0.5, 0.8))
	create_platform(globals.viewport*Vector2(0.8, 0.5))
	create_platform(globals.viewport*Vector2(0.2, 0.2))

	player.set_pos(globals.viewport*Vector2(0.5, 0.2))
	add_child(player)

	set_fixed_process(true)
	stage_pause()
