extends StaticBody2D

onready var sprite = get_node("sprite")
onready var cshape = get_node("cshape")

onready var bounce = globals.bounce*globals.gravity_scale

signal platform_active

func collision_handler(player):
	emit_signal("platform_active")
	player.set_linear_velocity(Vector2(player.get_linear_velocity().x, -bounce))
