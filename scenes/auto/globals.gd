extends Node2D

onready var device = OS.get_name()
onready var screen = get_viewport_rect().size
onready var vport = Rect2(Vector2(0, 0), get_viewport_rect().size)

const start = preload("res://scenes/start.tscn")
const stage = preload("res://scenes/stage.tscn")
const view = preload("res://scenes/view.tscn")
const player = preload("res://scenes/player.tscn")
const platform = preload("res://scenes/platform.tscn")
const enemy = preload("res://scenes/enemy.tscn")
const fire = preload("res://scenes/fire.tscn")

const gravity_scale = 12
const bounce = 800

var save_file
var hiscore
var input = {
	"ui_accept": false,
	"ui_accept_toggle": false,
	"ui_select": false,
	"ui_select_toggle": false,
	"ui_up": false,
	"ui_up_toggle": false,
	"ui_down": false,
	"ui_down_toggle": false,
	"ui_left": false,
	"ui_left_toggle": false,
	"ui_right": false,
	"ui_right_toggle": false,
	"ui_lclick": false,
	"ui_lclick_toggle": false,
	"ui_accelerometer": Vector3(0, 0, 0)
}

signal ui_accept_press
signal ui_accept_release
signal ui_select_press
signal ui_select_release
signal ui_up_press
signal ui_up_release
signal ui_down_press
signal ui_down_release
signal ui_left_press
signal ui_left_release
signal ui_right_press
signal ui_right_release
signal ui_lclick_press
signal ui_lclick_release

func input_handler():
	if Input.is_action_pressed("ui_accept") and not input.ui_accept:
		input.ui_accept = true
		input.ui_accept_toggle = not input.ui_accept_toggle
		emit_signal("ui_accept_press")
	if Input.is_action_pressed("ui_select") and not input.ui_select:
		input.ui_select = true
		input.ui_select_toggle = not input.ui_accept_toggle
		emit_signal("ui_select_press")
	elif Input.is_action_pressed("ui_up") and not input.ui_up:
		input.ui_up = true
		input.ui_up_toggle = not input.ui_up_toggle
		emit_signal("ui_up_press")
	elif Input.is_action_pressed("ui_down") and not input.ui_down:
		input.ui_down = true
		input.ui_down_toggle = not input.ui_down_toggle
		emit_signal("ui_down_press")
	elif Input.is_action_pressed("ui_left") and not input.ui_left:
		input.ui_left = true
		input.ui_left_toggle = not input.ui_left_toggle
		emit_signal("ui_left_press")
	elif Input.is_action_pressed("ui_right") and not input.ui_right:
		input.ui_right = true
		input.ui_right_toggle = not input.ui_right_toggle
		emit_signal("ui_right_press")
	elif Input.is_action_pressed("ui_lclick") and not input.ui_lclick:
		input.ui_lclick = true
		input.ui_lclick_toggle = not input.ui_lclick_toggle
		emit_signal("ui_lclick_press")

	if input.ui_accept and not Input.is_action_pressed("ui_accept"):
		input.ui_accept = false
		emit_signal("ui_accept_release")
	if input.ui_select and not Input.is_action_pressed("ui_select"):
		input.ui_select = false
		emit_signal("ui_select_release")
	elif input.ui_up and not Input.is_action_pressed("ui_up"):
		input.ui_up = false
		emit_signal("ui_up_release")
	elif input.ui_down and not Input.is_action_pressed("ui_down"):
		input.ui_down = false
		emit_signal("ui_down_release")
	elif input.ui_left and not Input.is_action_pressed("ui_left"):
		input.ui_left = false
		emit_signal("ui_left_release")
	elif input.ui_right and not Input.is_action_pressed("ui_right"):
		input.ui_right = false
		emit_signal("ui_right_release")
	elif input.ui_lclick and not Input.is_action_pressed("ui_lclick"):
		input.ui_lclick = false
		emit_signal("ui_lclick_release")

	input.ui_accelerometer = Input.get_accelerometer()

func save(val):
	if val > hiscore:
		hiscore = val
		save_file.open("user://udata.save", File.WRITE)
		save_file.store_line(str(hiscore))
		save_file.close()

func _fixed_process(d):
	input_handler()

func _ready():
	save_file = File.new()

	if save_file.file_exists("user://udata.save"):
		save_file.open("user://udata.save", File.READ)
		hiscore = int(save_file.get_line())
		save_file.close()
	else:
		save(0)

	randomize()

	set_pause_mode(PAUSE_MODE_PROCESS)
	set_fixed_process(true)
