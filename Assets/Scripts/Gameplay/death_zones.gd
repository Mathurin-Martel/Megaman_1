extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is MegaMan:
		body.die()
	else:
		#Changer ca pour que les ennemis meurent quand ils tombent vraiment
		queue_free()
