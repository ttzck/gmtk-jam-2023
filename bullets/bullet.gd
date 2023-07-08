extends CharacterBody2D

@export var speed = 100

func _physics_process(delta):
	var bound = get_viewport_rect().size
	if global_position.x > bound.x or global_position.x < 0:
		rotation = PI - rotation
	if global_position.y > bound.y or global_position.y < 0:
		rotation *= -1
	var fwd = transform.basis_xform(Vector2.RIGHT)
	move_and_collide(fwd * speed * delta)
