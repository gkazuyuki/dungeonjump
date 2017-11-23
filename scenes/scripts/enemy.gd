extends RigidBody2D

onready var sprite = get_node("sprite")
onready var anima = get_node("sprite/anima")
onready var death = get_node("death")
onready var death_anim = get_node("death/anima")
onready var contact = get_node("contact")
onready var sfx = get_node("sfx")

onready var size = sprite.get_scale()*sprite.get_item_rect().size

const dspeed = 100

var ispeed = dspeed
var active = true

signal enemy_death

func death():
	active = false
	contact.queue_free()
	anima.play("Hit")
	sfx.play("fx_kill")
	yield(anima, "finished")
	sprite.hide()
	death.show()
	death_anim.play("Regular")
	yield(death_anim, "finished")
	death.hide()
	emit_signal("enemy_death")

func flip():
	sprite.set_flip_h(not sprite.is_flipped_h())
	for i in get_children():
		if i.get_type() == "Area2D":
			i.get_child(0).set_pos(Vector2(-1, 1)*i.get_child(0).get_pos())

func on_body_enter(body):
	if body.get_parent().is_in_group("magic"):
		body.get_parent().active = false
		body.hide()
		death()

func _fixed_process(d):
	if ispeed >= 0 or sprite.is_flipped_h():
		if not (ispeed >= 0 and sprite.is_flipped_h()):
			flip()

func _integrate_forces(s):
	if get_pos().x - size.x < 0:
		ispeed = dspeed
	elif get_pos().x + size.x > globals.vport.size.x:
		ispeed = -dspeed

	s.set_linear_velocity(Vector2(ispeed, 0))
	if not anima.is_playing():
			anima.play("Idle")

func _ready():
	set_gravity_scale(0)
	death.hide()

	contact.connect("body_enter", self, "on_body_enter")
	if randf() < 0.5:
		set_linear_velocity(Vector2(-dspeed, 0))
	else:
		set_linear_velocity(Vector2(dspeed, 0))

	set_fixed_process(true)
