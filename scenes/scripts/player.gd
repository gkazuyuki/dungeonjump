extends RigidBody2D

onready var sprite = get_node("sprite")
onready var cshape = get_node("cshape")

onready var direction = get_node("direction")

const accel = 1250
var speed = 0

signal platform_hit(player)

func _integrate_forces(s):
	for i in range(0, s.get_contact_count()):
		if s.get_contact_collider_object(i).is_in_group("platform"):
			if s.get_contact_local_normal(i) == Vector2(0, -1):
				emit_signal("platform_hit", self)

	s.set_linear_velocity(Vector2(speed, s.get_linear_velocity().y))
	direction.set_pos(get_linear_velocity().normalized()*60)

func _fixed_process(d):
	if globals.action.ui_left and speed > -globals.max_speed:
		speed -= accel*d
	elif globals.action.ui_right and speed < globals.max_speed:
		speed += accel*d

func _ready():
	set_max_contacts_reported(3)
	set_contact_monitor(true)

	set_gravity_scale(globals.gravity_scale)
	set_fixed_process(true)
