extends Area2D
signal collected(item)

func _on_body_entered(body):
	if body.is_in_group("player"):
		collected.emit(self)
