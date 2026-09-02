extends Area2D


func _on_area_exited(area: Area2D) -> void:
	GlobalTransition.animation_fade_out()
	await get_tree().create_timer(2.0).timeout
	$"../../player".desativar_player()
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://JumpOfThePigeon/scenes/worlds/world01/level02/level02.tscn")
	pass
