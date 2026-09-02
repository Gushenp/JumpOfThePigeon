extends Node2D


func _on_espinho_00_body_entered(body: Node2D) -> void:
	$"../player".eliminar_player()
	pass # Replace with function body.
