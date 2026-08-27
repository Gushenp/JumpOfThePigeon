extends Area2D


func _on_area_exited(area: Area2D) -> void:
	GlobalTransition.animation_fade_out()
	await get_tree().create_timer(0.3).timeout
	$"../../player".desatvar_controles()
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("")
	pass
