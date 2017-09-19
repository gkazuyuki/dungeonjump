extends RigidBody2D

onready var sprite = get_node("sprite")
onready var cshape = get_node("cshape")

onready var direction = get_node("direction")

onready var speed = globals.speed

var action = {
	"move_left": false,
	"move_right": false
}

func input_handler():
	if not (globals.action.ui_left and globals.action.ui_right):
		if globals.action.ui_left:
			if not action.move_left:
				action.move_left = true
				action.move_right = false
		elif globals.action.ui_right:
			if not action.move_right:
				action.move_left = false
				action.move_right = true

func _fixed_process(d):
	var new_velocity

	input_handler()

	if action.move_left:
		new_velocity = Vector2(-speed, get_linear_velocity().y)
		set_linear_velocity(new_velocity)
		action.move_left = false
	if action.move_right:
		new_velocity = Vector2(speed, get_linear_velocity().y)
		set_linear_velocity(new_velocity)
		action.move_right = false

	for i in get_colliding_bodies():
		if i.get_name() == "platform":
			i.collision_handler(get_node("."))

	direction.set_pos(get_linear_velocity().normalized()*60)

func _ready():
	set_max_contacts_reported(5)
	set_contact_monitor(true)

	set_gravity_scale(globals.gravity_scale)
	set_fixed_process(true)
