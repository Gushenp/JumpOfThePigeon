extends Area2D

signal eliminar_player


func _on_body_entered(body: Node2D) -> void:
	$"../../player".eliminar_player()
	pass # Replace with function body.
