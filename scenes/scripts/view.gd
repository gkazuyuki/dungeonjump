extends Node2D

onready var top = get_node("top")
onready var bottom = get_node("bottom")
onready var mp = get_node("top/mp")
onready var mp_text = get_node("top/mp/text")
onready var hp = get_node("top/hp")
onready var hp_text = get_node("top/hp/text")
onready var score = get_node("top/score")
onready var pause = get_node("top/pause")
onready var skill1 = get_node("bottom/skill1")

onready var screen = globals.screen
onready var size = top.get_scale()*top.get_item_rect().size

func _ready():
	globals.vport.pos = Vector2(0, size.y)
	globals.vport.size = Vector2(screen.x, screen.y - 2*size.y)

	top.set_pos(Vector2(0, -(screen.y - size.y)/2))
	bottom.set_pos(Vector2(0, (screen.y - size.y)/2))
