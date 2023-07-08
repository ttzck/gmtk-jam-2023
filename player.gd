extends CharacterBody2D
@export var movement_speed = 10
signal died
var is_collided = false

func _process(delta):
	$PlayerSprite.modulate = Color(randf(), randf(), randf())


func _physics_process(delta):
	if is_collided:
		is_collided = false
		get_tree().reload_current_scene()
	
	var movement = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		movement += Vector2.UP
	if Input.is_action_pressed("move_left"):
		movement += Vector2.LEFT
	if Input.is_action_pressed("move_down"):
		movement += Vector2.DOWN
	if Input.is_action_pressed("move_right"):
		movement += Vector2.RIGHT
	
	velocity = movement.normalized() * movement_speed
	is_collided = move_and_slide()
	
#huhu

func _on_button_pressed():
	print("BUTTON PRESSED")

