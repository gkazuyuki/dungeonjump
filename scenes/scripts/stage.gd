extends Node2D

onready var view = globals.view.instance()
onready var player = globals.player.instance()
onready var platform = globals.platform
onready var enemy = globals.enemy
onready var fire = globals.fire

onready var bg = get_node("bg")
onready var bg_aux = get_node("bg_aux")

onready var screen = globals.screen
onready var vport

var score = 0
var last_platform
var last_enemy
var magic_active = false

signal stage_reset

func create_enemy(n):
	var new_enemy
	var pos

	for i in range(0, n):
		new_enemy = enemy.instance()
		add_child(new_enemy)
		if last_enemy == null:
			pos = vport.size*Vector2(0.6*randf() + 0.2, 0.1*randf())
			pos.y = pos.y - vport.pos.y
		else:
			pos = vport.size*Vector2(0.8*randf() + 0.1, randf() + 1)
			pos.y = last_enemy.get_pos().y - pos.y
		new_enemy.set_pos(pos)
		new_enemy.connect("enemy_death", self, "on_enemy_death")
		last_enemy = new_enemy
	move_child(player, get_children().size() - 1)
	move_child(view, get_children().size() - 1)

func create_platform(n):
	var new_platform
	var pos

	for i in range(0, n):
		new_platform = platform.instance()
		add_child(new_platform)
		if last_platform == null:
			pos = vport.size*Vector2(0.6*randf() + 0.2, 0.1*randf() + 0.7)
			pos.y = pos.y + view.size.y
		else:
			pos = vport.size*Vector2(0.8*randf() + 0.1, 0.2*randf() + 0.1)
			pos.y = last_platform.get_pos().y - pos.y
		new_platform.set_pos(pos)
		move_child(new_platform, 3)
		player.connect("platform_active", new_platform, "on_platform_active")
		last_platform = new_platform

func move_camera(d):
	score += int(d/3)
	view.score.set_text(str(score))

	if vport.pos.y - last_platform.get_pos().y < vport.size.y:
		create_platform(10)

	if vport.pos.y - last_enemy.get_pos().y < vport.size.y:
		create_enemy(3)

	for i in get_children():
		if i.is_in_group("stage_obj"):
			i.set_pos(i.get_pos() + Vector2(0, d))
			if i.get_pos().y > vport.end.y:
				if i.is_in_group("magic"):
					magic_active = false
				i.free()

	bg.set_pos(bg.get_pos() + Vector2(0, d))
	bg_aux.set_pos(bg_aux.get_pos() + Vector2(0, d))
	if bg.get_pos().y > screen.y/2:
		bg.set_pos(bg.get_pos() - Vector2(0, 954/2))
		bg_aux.set_pos(bg_aux.get_pos() - Vector2(0, 954/2))

func on_enemy_death():
	score += 100
	view.score.set_text(str(int(score)))

func on_player_cast():
	var new_magic

	if not magic_active and player.mp > 0:
		magic_active = true
		player.mp -= 1
		new_magic = fire.instance()
		new_magic.set_pos(player.get_pos())
		add_child(new_magic)
		move_child(new_magic, get_children().size() - 1)
		move_child(view, get_children().size() - 1)

func on_player_view_leave(side):
	if side == "bottom":
		reset()
	else:
		var new_pos_x

		if side == "left":
			new_pos_x = vport.end.x + player.size.x/4
		elif side == "right":
			new_pos_x = vport.pos.x - player.size.x/4
		player.set_pos(Vector2(new_pos_x, player.get_pos().y))

func quit():
	globals.save(score)
	get_tree().change_scene_to(globals.start)

func pause():
	get_tree().set_pause(not get_tree().is_paused())

func reset():
	emit_signal("stage_reset")
	globals.save(score)
	score = 0
	view.score.set_text(str(int(score)))

	bg.set_pos(Vector2(0, 0))
	bg_aux.set_pos(Vector2(-15, -954))

	last_platform = null
	for i in get_children():
		if i.is_in_group("platform"):
			i.free()
	create_platform(10)
	last_enemy = null
	for i in get_children():
		if i.is_in_group("enemy"):
			i.free()
	create_enemy(3)
	for i in get_children():
		if i.is_in_group("magic"):
			i.free()
	magic_active = false

	player.set_pos(Vector2(screen.x/2, vport.end.y - player.size.y/2))
	view.set_pos(screen*Vector2(0.5, 0.5))
	move_child(player, get_children().size() - 1)
	move_child(view, get_children().size() - 1)

func _fixed_process(d):
	if player.get_pos().y < view.get_pos().y - 0.1*vport.size.y:
		move_camera(view.get_pos().y - 0.1*vport.size.y - player.get_pos().y)

	if magic_active:
		for i in get_children():
			if i.is_in_group("magic"):
				if i.active:
					if i.left.get_pos().x < 0:
						if i.right.get_pos().x > vport.size.x:
							i.free()
							magic_active = false

	view.hp_text.set_text(str(player.hp))
	view.mp_text.set_text(str(player.mp))

func _ready():
	add_child(view)
	vport = globals.vport

	view.pause.connect("pressed", self, "pause")
	view.skill1.connect("pressed", self, "on_player_cast")
	globals.connect("ui_down_press", self, "on_player_cast")

	add_child(player)

	for i in get_children():
		if i.is_in_group("stage_obj"):
			connect("stage_reset", i, "reset")
	player.connect("view_leave", self, "on_player_view_leave")
	player.connect("player_death", self, "reset")
	globals.connect("ui_accept_press", self, "pause")
	globals.connect("ui_select_press", self, "quit")
	reset()
	set_fixed_process(true)
