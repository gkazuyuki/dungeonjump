extends Node2D

onready var logo = get_node("logo")
onready var anima = get_node("logo/anima")
onready var start = get_node("start")
onready var quit = get_node("quit")
onready var hiscore = get_node("hiscore")
onready var sfx = get_node("sfx")

onready var size = start.get_scale()*start.get_item_rect().size
var sfx_fired = false

signal sfx_finished

func on_hover():
	sfx.play("fx_select", true)
	sfx_fired = true

func on_start():
	sfx.play("fx_start", true)
	sfx_fired = true
	yield(self, "sfx_finished")
	get_tree().change_scene_to(globals.stage)

func on_quit():
	sfx.play("fx_start", true)
	sfx_fired = true
	yield(self, "sfx_finished")
	get_tree().quit()

func _process(d):
	if not sfx.is_active() and sfx_fired:
		emit_signal("sfx_finished")
		sfx_fired = false

func _ready():
	logo.set_pos(globals.screen*Vector2(0.5, 0.2))
	start.set_pos(globals.screen*Vector2(0.22, 0.4))
	start.get_node("text").set_pos(Vector2(size.x/13, 0))
	quit.set_pos(globals.screen*Vector2(0.22, 0.6))
	quit.get_node("text").set_pos(Vector2(size.x/12, 0))
	hiscore.set_pos(globals.screen*Vector2(0.1, 0.8))
	hiscore.set_text(str("hi-score: ", globals.hiscore))

	start.connect("mouse_enter", self, "on_hover")
	quit.connect("mouse_enter", self, "on_hover")
	start.connect("pressed", self, "on_start")
	quit.connect("pressed", self, "on_quit")

	set_process(true)

	anima.play("Idle")
