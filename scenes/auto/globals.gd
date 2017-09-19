extends Node2D

onready var viewport = get_viewport_rect().size

var stage = preload("res://scenes/stage.tscn")
var player = preload("res://scenes/player.tscn")
var platform = preload("res://scenes/platform.tscn")

var gravity_scale = 10
var speed = 200
var bounce = 70

var action = {
	"ui_accept": false,
	"ui_left": false,
	"ui_right": false
}

func input_handler():
	if Input.is_action_pressed("ui_accept") and not action.ui_accept:
		action.ui_accept = true
	elif Input.is_action_pressed("ui_left") and not action.ui_left:
		action.ui_left = true
	elif Input.is_action_pressed("ui_right") and not action.ui_right:
		action.ui_right = true

	if action.ui_accept and not Input.is_action_pressed("ui_accept"):
		action.ui_accept = false
	elif action.ui_left and not Input.is_action_pressed("ui_left"):
		action.ui_left = false
	elif action.ui_right and not Input.is_action_pressed("ui_right"):
		action.ui_right = false

func _fixed_process(d):
	input_handler()

func _ready():
	set_pause_mode(PAUSE_MODE_PROCESS)
	set_fixed_process(true)
