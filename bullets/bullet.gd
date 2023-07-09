class_name Bullet extends CharacterBody2D

@export var speed = 100

enum TypeEnum {COLLECTABLE, HARMFUL}
var type : TypeEnum


func _ready():
	update_visuals()
	
func update_visuals():
	match type:
		TypeEnum.COLLECTABLE:
			$Sprite_pea.hide()
			$Sprite_beret.show()
		TypeEnum.HARMFUL:
			$Sprite_pea.show()
			$Sprite_beret.modulate.h = randf()
			$Sprite_beret.modulate.s = 1.0
			$Sprite_beret.hide()


func _physics_process(delta):
	var bound = get_viewport_rect().size
	if global_position.x > bound.x or global_position.x < 0:
		rotation = PI - rotation
	if global_position.y > bound.y or global_position.y < 0:
		rotation *= -1
	var fwd = transform.basis_xform(Vector2.RIGHT)
	if type == TypeEnum.HARMFUL:
		move_and_collide(fwd * speed * delta)


func swap_type():
	match type:
		TypeEnum.COLLECTABLE:
			type = TypeEnum.HARMFUL
		TypeEnum.HARMFUL:
			type = TypeEnum.COLLECTABLE
	update_visuals()
