extends Node2D

var bullet = preload("res://bullets/bullet.tscn")
var bullet_spawn_point = preload("res://bullets/bullet_spawn_point.tscn")
var item = preload("res://item.tscn")


func _ready():
	spawn_item()
	
	
func spawn_item():
	var rand_pos = get_rand_screen_pos()
	var item_inst : Node2D = item.instantiate()
	item_inst.global_position = rand_pos
	item_inst.connect("collected", on_item_collected)
	add_child(item_inst)
	
	
func on_item_collected(item):
	item.queue_free()
	$Player/Bubble.set_active(true)
	
	await get_tree().create_timer(5).timeout
	
	$Player/Bubble.set_active(false)
	spawn_item()

func spawn_bullet():
	var rand_pos = get_rand_screen_pos()
	
	var spawn_point_inst : Node2D = bullet_spawn_point.instantiate()
	spawn_point_inst.global_position = rand_pos
	add_child(spawn_point_inst)
	
	await get_tree().create_timer(1).timeout
	
	spawn_point_inst.queue_free()
	
	var bullet_inst : Node2D = bullet.instantiate()
	bullet_inst.global_position = rand_pos
	bullet_inst.rotation = randf() * 2 * PI
	add_child(bullet_inst)
	


func get_rand_screen_pos():
	var arena_rect = get_viewport_rect().size
	return Vector2(randf() * arena_rect.x, randf() * arena_rect.y)


func _on_bullet_spawn_timer_timeout():
	spawn_bullet()
