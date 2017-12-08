extends RigidBody2D

onready var sprite = get_node("sprite")
onready var anima = get_node("sprite/anima")
onready var attack = get_node("attack")
onready var hit = get_node("hit")
onready var sfx = get_node("sfx")

onready var vport = globals.vport
onready var size = sprite.get_scale()*sprite.get_item_rect().size

const max_speed = 925
const dspeed = 1250
const friction = 0.9

var hp = 3
var mp = 2
var magic_active = false
var ispeed = 0
var immune = false
var last_hit
var collider = {
	"node": "",
	"groups": [],
	"normal": Vector2(0, 0)
}

signal player_death
signal view_leave(side)
signal platform_active(platform)

func attack():
	var enemy_attacked

	if not (anima.is_playing() or get_tree().is_paused()):
		anima.play("Attack")
		sfx.play("fx_attack", true)
		for i in attack.get_overlapping_areas():
			if i.get_parent().is_in_group("enemy"):
				if i.get_parent().anima.get_current_animation() != "Hit":
					immune = true
					enemy_attacked = i.get_parent()
					enemy_attacked.death()
					yield(enemy_attacked, "enemy_death")
					last_hit = null
		yield(anima, "finished")

func flip():
	sprite.set_flip_h(not sprite.is_flipped_h())
	for i in get_children():
		if i.get_type() == "CollisionShape2D":
			i.set_pos(Vector2(-1, 1)*i.get_pos())
		elif i.get_type() == "Area2D":
			i.get_child(0).set_pos(Vector2(-1, 1)*i.get_child(0).get_pos())

func reset():
	hp = 3
	mp = 5
	ispeed = 0
	last_hit = null
	set_linear_velocity(Vector2(0, -globals.bounce))
	anima.stop()
	sprite.set_frame(0)

func _fixed_process(d):
	vport = globals.vport

	if get_pos().x + size.x/4 < vport.pos.x:
		emit_signal("view_leave", "left")
	elif get_pos().x - size.x/4 > vport.end.x:
		emit_signal("view_leave", "right")
	if get_pos().y - size.y/4 > vport.end.y:
		sfx.play("fx_death", true)
		emit_signal("view_leave", "bottom")

	if ispeed >= 0 or not sprite.is_flipped_h():
		if not ispeed >= 0 or sprite.is_flipped_h():
			flip()

	for i in hit.get_overlapping_areas():
		if i.get_parent().is_in_group("enemy") and not immune:
			if i.get_parent().anima.get_current_animation() != "Hit":
				if not anima.is_playing():
					anima.play("Hit")
					sfx.play("fx_hit", true)
				hp -= 1
				immune = true
				last_hit = i.get_parent()
	if last_hit != null:
		if last_hit.active:
				if not hit.overlaps_area(last_hit.contact):
					immune = false
					last_hit = null
	else:
		immune = false

	if hp <= 0:
		emit_signal("player_death")

func _integrate_forces(s):
	for i in range(0, s.get_contact_count()):
		collider.node = s.get_contact_collider_object(i)
		collider.groups = s.get_contact_collider_object(i).get_groups()
		collider.normal = s.get_contact_local_normal(i)

		if "platform" in collider.groups and collider.normal == Vector2(0, -1):
			emit_signal("platform_active", collider.node)

	if globals.device in ["X11", "Windows", "HTML5"]:
		if globals.input.ui_left and ispeed > -max_speed:
			ispeed -= (dspeed - abs(ispeed*friction))*s.get_step()
		elif globals.input.ui_right and ispeed < max_speed:
			ispeed += (dspeed - abs(ispeed*friction))*s.get_step()
	elif globals.device == "Android":
		ispeed = globals.input.ui_accelerometer.x
		if abs(ispeed) > 8:
			ispeed = -ispeed/abs(ispeed)*max_speed
		else:
			ispeed = -ispeed/8*max_speed/0.7

	s.set_linear_velocity(Vector2(ispeed, s.get_linear_velocity().y))

	if not (s.get_linear_velocity().y < 0 and sprite.get_frame() == 1):
		if s.get_linear_velocity().y < 0 or sprite.get_frame() == 1:
			if not anima.is_playing():
				sprite.set_frame((sprite.get_frame() + 1) % 2)

func _ready():
	set_max_contacts_reported(3)
	set_contact_monitor(true)

	globals.connect("ui_up_press", self, "attack")
	globals.connect("ui_lclick_press", self, "attack")

	set_gravity_scale(globals.gravity_scale)
	set_fixed_process(true)
