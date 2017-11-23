extends Node2D

onready var left = get_node("left")
onready var left_sprite = get_node("left/sprite")
onready var left_anim = get_node("left/sprite/anima")
onready var right = get_node("right")
onready var right_sprite = get_node("right/sprite")
onready var right_anim = get_node("right/sprite/anima")
onready var sfx = get_node("sfx")

var dspeed = 300
var active = true

func _ready():
	left.set_gravity_scale(0)
	right.set_gravity_scale(0)

	left_anim.play("Idle")
	right_anim.play("Idle")
	sfx.play("fx_fire")

	left.set_linear_velocity(Vector2(-dspeed, 0))
	right.set_linear_velocity(Vector2(dspeed, 0))

	set_fixed_process(true)
