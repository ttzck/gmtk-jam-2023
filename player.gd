extends CharacterBody2D
@export var movement_speed = 10
signal died
var canDash = true
var dashing = false
var movement = Vector2.ZERO
var dashRange = 5

func _process(delta):
	$PlayerSprite.modulate = Color(randf(), randf(), randf())
	dash()


func _physics_process(delta):
	if not dashing:
		movement = Vector2.ZERO
		if Input.is_action_pressed("move_up"):
			movement += Vector2.UP
		if Input.is_action_pressed("move_left"):
			movement += Vector2.LEFT
		if Input.is_action_pressed("move_down"):
			movement += Vector2.DOWN
		if Input.is_action_pressed("move_right"):
			movement += Vector2.RIGHT
		
	velocity = movement.normalized() * movement_speed
	move_and_slide()
	
func dash():
	if Input.is_action_just_pressed("dash") and canDash:
		movement_speed = movement_speed * dashRange
		canDash = false
		dashing = true
		await get_tree().create_timer(0.1).timeout
		dashing = false
		canDash = true
		movement_speed = movement_speed / dashRange / 2
		await get_tree().create_timer(0.2).timeout
		movement_speed = movement_speed * 2
		
func _on_button_pressed():
	print("BUTTON PRESSED")
