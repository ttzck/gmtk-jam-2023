extends CharacterBody2D
@export var movement_speed = 10
@export var dash_duration = 0.1
@export var dash_recovery = 0.2
@export var dash_speed = 3

var canDash = true
var dashing = false
var movement = Vector2.ZERO
var score = 0

var player_up = preload("res://sprites/player_up.png")
var player_down = preload("res://sprites/player_down.png")
var player_left = preload("res://sprites/player_left.png")
var player_right = preload("res://sprites/player_right.png")

func _process(delta):
	$PlayerSprite.modulate = Color(randf(), randf(), randf())
	dash()


func _physics_process(delta):
	if not dashing:
		update_movement_input()
		
	velocity = movement.normalized() * movement_speed
	if move_and_slide():
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			if collision.get_collider().is_in_group("bullets"):
				if collision.get_collider().type == Bullet.TypeEnum.COLLECTABLE:
					score += 1
					collision.get_collider().queue_free()
				elif collision.get_collider().type == Bullet.TypeEnum.HARMFUL:
					get_tree().reload_current_scene()
	global_position = global_position.clamp(Vector2.ZERO, get_viewport_rect().size)


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
	update_sprite()


func dash():
	if Input.is_action_just_pressed("dash") and not dashing:
		dashing = true
		collision_mask -= 2 # remove bullets from collision mask
		movement_speed = movement_speed * dash_speed
		await get_tree().create_timer(dash_duration).timeout
		movement_speed = movement_speed / dash_speed / 2
		await get_tree().create_timer(dash_recovery).timeout
		movement_speed = movement_speed * 2
		collision_mask += 2
		dashing = false


func _on_button_pressed():
	print("BUTTON PRESSED")
	
func update_sprite():
	if movement.x > 0:
		$PlayerSprite.texture = player_right
	if movement.x < 0:
		$PlayerSprite.texture = player_left
	if movement.y > 0:
		$PlayerSprite.texture = player_down
	if movement.y < 0:
		$PlayerSprite.texture = player_up
	

