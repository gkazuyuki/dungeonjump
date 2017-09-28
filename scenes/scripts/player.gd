extends RigidBody2D

onready var sprite = get_node("sprite")
onready var cshape = get_node("cshape")

onready var direction = get_node("direction")

var speed = 0
var accel = 2000

signal platform_on_land(player)

func input_handler(d):
	if globals.action.ui_left and speed > -globals.max_speed:
		speed -= accel*d
	elif globals.action.ui_right and speed < globals.max_speed:
		speed += accel*d

func _integrate_forces(s):
	var collisions = s.get_contact_count()

	for i in range(0, collisions):
		collider = s.get_contact_collider_object(i)
		if s.get_contact_collider_object(i).is_in_group("platform"):
			if s.get_contact_local_normal(i).normalized() == Vector2(0, -1):
				emit_signal("platform_on_land", get_node("."))

	s.set_linear_velocity(Vector2(speed, get_linear_velocity().y))

func _fixed_process(d):
	input_handler(d)

	direction.set_pos(get_linear_velocity().normalized()*60)

func _ready():
	set_max_contacts_reported(3)
	set_contact_monitor(true)

	set_gravity_scale(globals.gravity_scale)
	set_fixed_process(true)
