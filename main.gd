extends Node2D

@export var bullet : PackedScene
@export var bullet_spawn_point : PackedScene

func spawn_bullet():
	var arena_rect = get_viewport_rect().size
	var rand_pos = Vector2(randf() * arena_rect.x, randf() * arena_rect.y)
	
	var spawn_point_inst : Node2D = bullet_spawn_point.instantiate()
	spawn_point_inst.global_position = rand_pos
	add_child(spawn_point_inst)
	
	await get_tree().create_timer(1).timeout
	
	spawn_point_inst.queue_free()
	
	var bullet_inst : Node2D = bullet.instantiate()
	bullet_inst.global_position = rand_pos
	bullet_inst.rotation = randf() * 2 * PI
	add_child(bullet_inst)
	


func _on_bullet_spawn_timer_timeout():
	spawn_bullet()
