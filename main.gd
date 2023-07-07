extends Node2D

@export var obstacle : PackedScene

func _process(delta):
	var inst : Node2D = obstacle.instantiate()
	inst.global_position = Vector2(randf_range(0, 1000), randf_range(0, 1000))
	add_child(inst)
