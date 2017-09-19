extends StaticBody2D

onready var sprite = get_node("sprite")
onready var cshape = get_node("cshape")

onready var bounce = globals.bounce*globals.gravity_scale

func collision_handler(player):
	var cshape_pos = get_pos() + cshape.get_pos()
	var new_velocity

	if (cshape_pos.y - player.get_pos().y) > player.get_item_rect().size.y/2:
		new_velocity = Vector2(player.get_linear_velocity().x, -bounce)
		player.set_linear_velocity(new_velocity)
