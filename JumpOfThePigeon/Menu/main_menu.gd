extends Control

@onready var music_menu = $MusicMenu

func _ready() -> void:
	$MusicMenu.play()
	$background_animated/Player.play("sleep")
	pass 


func _on_start_pressed() -> void:
	await GlobalTransition.animation_fade_out(music_menu, -80, 6.0)
	get_tree().change_scene_to_file("res://JumpOfThePigeon/Worlds/World1/Levels/level1/level1.tscn")
	pass
