extends CharacterBody2D
@export var movement_speed = 10
@export var dash_duration = 0.1
@export var dash_recovery = 0.2

var canDash = true
var dashing = false
var movement = Vector2.ZERO
var dash_speed = 5
var is_bullet = false


func _process(delta):
	$PlayerSprite.modulate = Color(randf(), randf(), randf())
	dash()


func _physics_process(delta):
	if is_bullet:
		var bound = get_viewport_rect().size
		if global_position.x > bound.x or global_position.x < 0:
			rotation = PI - rotation
		if global_position.y > bound.y or global_position.y < 0:
			rotation *= -1
		velocity = transform.basis_xform(Vector2.RIGHT) * movement_speed * 3
		move_and_slide()
	else:
		if not dashing:
			update_movement_input()
			
		velocity = movement.normalized() * movement_speed
		if move_and_slide():
			for i in get_slide_collision_count():
				var collision = get_slide_collision(i)
				if collision.get_collider().is_in_group("bullets"):
					get_tree().reload_current_scene()


func update_movement_input():
	movement = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		movement += Vector2.UP
	if Input.is_action_pressed("move_left"):
		movement += Vector2.LEFT
	if Input.is_action_pressed("move_down"):
		movement += Vector2.DOWN
	if Input.is_action_pressed("move_right"):
		movement += Vector2.RIGHT


func dash():
	if Input.is_action_just_pressed("dash") and not dashing and not is_bullet:
		dashing = true
		movement_speed = movement_speed * dash_speed
		await get_tree().create_timer(dash_duration).timeout
		movement_speed = movement_speed / dash_speed / 2
		await get_tree().create_timer(dash_recovery).timeout
		movement_speed = movement_speed * 2
		dashing = false


func _on_button_pressed():
	print("BUTTON PRESSED")

