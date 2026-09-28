extends Area2D

@export var next_level = ""

func _on_area_exited(area: Area2D) -> void:
	GlobalTransition.animation_fade_out()
	await get_tree().create_timer(2.0).timeout
	$"../../player".desativar_player()
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file(next_level)
	pass
