extends Node2D

onready var viewport = get_viewport_rect().size

var stage = preload("res://scenes/stage.tscn")
var player = preload("res://scenes/player.tscn")
var platform = preload("res://scenes/platform.tscn")

var gravity_scale = 20
var max_speed = 1000
var bounce = 50

var action = {
	"ui_accept": false,
	"ui_left": false,
	"ui_right": false
}

signal ui_accept_press
signal ui_accept_release
signal ui_left_press
signal ui_left_release
signal ui_right_press
signal ui_right_release

func input_handler():
	if Input.is_action_pressed("ui_accept") and not action.ui_accept:
		action.ui_accept = true
		emit_signal("ui_accept_press")
	elif Input.is_action_pressed("ui_left") and not action.ui_left:
		action.ui_left = true
		emit_signal("ui_left_press")
	elif Input.is_action_pressed("ui_right") and not action.ui_right:
		action.ui_right = true
		emit_signal("ui_right_press")

	if action.ui_accept and not Input.is_action_pressed("ui_accept"):
		action.ui_accept = false
		emit_signal("ui_accept_release")
	elif action.ui_left and not Input.is_action_pressed("ui_left"):
		action.ui_left = false
		emit_signal("ui_left_release")
	elif action.ui_right and not Input.is_action_pressed("ui_right"):
		action.ui_right = false
		emit_signal("ui_right_release")

func _fixed_process(d):
	input_handler()

func _ready():
	set_pause_mode(PAUSE_MODE_PROCESS)
	set_fixed_process(true)
