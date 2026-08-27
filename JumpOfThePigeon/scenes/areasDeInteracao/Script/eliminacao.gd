extends Area2D

signal eliminar_player


func _on_body_entered(body: Node2D) -> void:
	eliminar_player.emit()
	pass # Replace with function body.
