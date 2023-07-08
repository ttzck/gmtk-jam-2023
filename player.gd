extends CharacterBody2D
@export var movement_speed = 10
@export var dash_duration = 0.1
@export var dash_recovery = 0.2

var canDash = true
var dashing = false
var movement = Vector2.ZERO
var dash_speed = 5

func _process(delta):
	$PlayerSprite.modulate = Color(randf(), randf(), randf())
	dash()


func _physics_process(delta):
	if not dashing:
		update_movement_input()
		
	velocity = movement.normalized() * movement_speed
	if move_and_slide():
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
	if Input.is_action_just_pressed("dash") and not dashing:
		dashing = true
		movement_speed = movement_speed * dash_speed
		await get_tree().create_timer(dash_duration).timeout
		movement_speed = movement_speed / dash_speed / 2
		await get_tree().create_timer(dash_recovery).timeout
		movement_speed = movement_speed * 2
		dashing = false


func _on_button_pressed():
	print("BUTTON PRESSED")

