extends Node2D

# ==== Adição de nós =====
@onready var player = $player
@onready var elementos_globais = $map/elementos_globais
@onready var normal_map = $map/normal_map
@onready var other_map = $map/other_map
@onready var camera = $player/camera
@onready var oficialMusic = $map/elementos_globais/audios/oficial_music 

# ===== Variáveis de controle ======
var is_in_normal_map = true

# ===== Funções de iniciação
func _ready() -> void:
	_start()
	$player.change_reality.connect(_change_reality)
	pass 

func _start():
	GlobalTransition.animation_fade_in(oficialMusic, -15, 3.0)
	GlobalAudio.disable_sound_node(player)
	GlobalAudio.disable_sound_node(elementos_globais)
	await get_tree().create_timer(1.5).timeout
	GlobalAudio.enable_sound_node(player, 0)
	GlobalAudio.enable_sound_node(elementos_globais, 0)
	GlobalStateController.disable_collisions(elementos_globais)

# ==== Mudar realidade =====
func _change_reality():
	if is_in_normal_map:
		normal_map._desativar_realidade()
		other_map._reativar_realidade()
		is_in_normal_map = false
	else: 
		is_in_normal_map = true
		other_map._reativar_realidade()
		normal_map._reativar_realidade()

func _on_saída_body_entered(body: Node2D) -> void:
	if body == player:
		GlobalTransition.animation_fade_out(oficialMusic, -80, 4.0)
		GlobalAudio._fadeOut(oficialMusic, 6.0)
		await get_tree().create_timer(2.3).timeout
		get_tree().change_scene_to_file("res://JumpOfThePigeon/Worlds/World1/Levels/level2/level2.tscn")
	pass 
