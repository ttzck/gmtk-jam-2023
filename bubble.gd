extends Area2D


func _ready():
	set_active(false)


func set_active(active):
	visible = active
	monitoring = active


func _on_body_entered(body):
	if body.is_in_group("bullets"):
		body.queue_free()
