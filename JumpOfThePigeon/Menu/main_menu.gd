extends Control

@onready var music_menu = $MusicMenu

func _ready() -> void:
	GlobalTransition._animacao_fade_in(music_menu, 0, 2.0)
	$background_animated/Player.play("sleep")
	pass 

func _on_start_pressed() -> void:
	GlobalTransition._animacao_fade_out(music_menu, -80, 2.0)
	get_tree().change_scene_to_file("res://JumpOfThePigeon/Worlds/World1/Levels/level1/level1.tscn")
	pass
