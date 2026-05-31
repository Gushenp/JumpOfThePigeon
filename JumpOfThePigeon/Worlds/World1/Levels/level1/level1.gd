extends Node2D

# ==== Adição de nós =====
@onready var player = $player
@onready var elementos_globais = $map/elementos_globais
@onready var camera = $player/camera
@onready var oficialMusic = $map/elementos_globais/audios/oficial_music 

# ===== Funções de iniciação
func _ready() -> void:
	_start()
	pass 

func _start():
	GlobalTransition.animation_fade_in(oficialMusic, -15, 3.0)
	GlobalAudio.disable_sound_node(elementos_globais)
	GlobalAudio.disable_sound_node(player)
	GlobalStateController.change_property(elementos_globais, "is_gravity", false)
	GlobalStateController.change_property(player, "is_control_active", false)
	await get_tree().create_timer(1.5).timeout
	GlobalStateController.change_property(player, "is_control_active", true)
	GlobalStateController.change_property(elementos_globais, "is_gravity", true)
	await get_tree().create_timer(1.0).timeout
	GlobalAudio.enable_sound_node(player, 0)
	GlobalAudio.enable_sound_node(elementos_globais, 0)

func _on_saída_body_entered(body: Node2D) -> void:
	if body == player:
		GlobalTransition.animation_fade_out(oficialMusic, -80, 4.0)
		await get_tree().create_timer(2.3).timeout
		get_tree().change_scene_to_file("res://JumpOfThePigeon/Worlds/World1/Levels/level2/level2.tscn")
	pass 
	
func _on_death_zone_body_entered(body: CharacterBody2D) -> void:
	player._eliminar_player()
	GlobalTransition.animation_fade_out(oficialMusic, -80, 4.0)
	pass
