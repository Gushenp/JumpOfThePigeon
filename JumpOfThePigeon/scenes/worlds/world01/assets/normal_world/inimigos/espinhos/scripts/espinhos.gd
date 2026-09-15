extends Node2D


func _on_espinho_00_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		$"../../../player".eliminar_player()
	pass # Replace with function body.
