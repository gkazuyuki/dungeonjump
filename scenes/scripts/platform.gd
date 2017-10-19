extends StaticBody2D

onready var sprite = get_node("sprite")
onready var cshape = get_node("cshape")
onready var sides = get_node("sides")

const bounce = 700

signal platform_active

func on_body_hit(body):
	emit_signal("platform_active")
	if body.is_in_group("bouncing"):
		body.set_linear_velocity(Vector2(body.get_linear_velocity().x, -bounce))

func on_body_enter(body):
	if body.is_in_group("bouncing"):
		body.add_collision_exception_with(self)

func on_body_exit(body):
	if body.is_in_group("bouncing"):
		body.remove_collision_exception_with(self)

func _ready():
	sides.connect("body_enter", self, "on_body_enter")
	sides.connect("body_exit", self, "on_body_exit")
