extends CharacterBody2D

@export var speed = 100

func _physics_process(delta):
	move_and_collide(transform.basis_xform(Vector2.RIGHT) * speed * delta)
