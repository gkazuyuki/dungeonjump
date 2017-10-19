extends Node2D

onready var player = globals.player.instance()
onready var platform = globals.platform

var pause_state = true

func stage_pause():
	get_tree().set_pause(pause_state)
	pause_state = not pause_state

func create_platform(pos):
	var new_platform = platform.instance()

	new_platform.set_pos(pos)
	player.connect("platform_hit", new_platform, "on_body_hit")
	add_child(new_platform)

	return new_platform

func _fixed_process(d):
	if player.get_pos().x < 0:
		player.set_pos(Vector2(globals.viewport.x, player.get_pos().y))
	elif player.get_pos().x > globals.viewport.x:
		player.set_pos(Vector2(0, player.get_pos().y))
	if player.get_pos().y > globals.viewport.y:
		player.speed = 0
		player.set_linear_velocity(Vector2(0, 0))
		player.set_pos(globals.viewport*Vector2(0.5, 0.2))

func _ready():
	globals.connect("ui_accept_press", self, "stage_pause")

	create_platform(globals.viewport*Vector2(0.5, 0.8))
	create_platform(globals.viewport*Vector2(0.8, 0.5))
	create_platform(globals.viewport*Vector2(0.2, 0.2))

	player.set_pos(globals.viewport*Vector2(0.5, 0.2))
	add_child(player)

	set_fixed_process(true)
	stage_pause()
