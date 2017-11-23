extends StaticBody2D

onready var sides = get_node("sides")
onready var sfx = get_node("sfx")

var sprite
var anima
var type
var size
var bounce_mod

func on_platform_active(platform):
	if platform == self:
		anima.play("Hit")
		sfx.play("fx_bounce", true)
		if type == "fake":
			yield(anima, "finished")
			queue_free()

func on_body_enter(body):
	if body.is_in_group("bouncing"):
		body.add_collision_exception_with(self)

func on_body_exit(body):
	if body.is_in_group("bouncing"):
		body.remove_collision_exception_with(self)

func _ready():
	type = randf()

	if type < 0.1:
		type = "fake"
		sprite = get_node("fake")
		anima = get_node("fake/anima")
		get_node("regular").hide()
		get_node("special").hide()
		bounce_mod = 1
	elif type < 0.2:
		type = "special"
		sprite = get_node("special")
		anima = get_node("special/anima")
		get_node("regular").hide()
		get_node("fake").hide()
		bounce_mod = 1.75
	else:
		type = "regular"
		sprite = get_node("regular")
		anima = get_node("regular/anima")
		get_node("special").hide()
		get_node("fake").hide()
		bounce_mod = 1

	set_constant_linear_velocity(Vector2(0, -globals.bounce*bounce_mod))
	size = sprite.get_scale()*get_item_rect().size

	sides.connect("body_enter", self, "on_body_enter")
	sides.connect("body_exit", self, "on_body_exit")
