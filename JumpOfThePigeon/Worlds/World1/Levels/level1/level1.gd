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
	GlobalAudio._fadeIn(oficialMusic, 2.0, 0)
	player._desativar_sons()
	elementos_globais._desativar_sons()
	elementos_globais._desativar_areas()
	TransiçãoGlobal._animacao_fade_in(0)
	await get_tree().create_timer(1.5).timeout
	elementos_globais._reativar_sons()
	elementos_globais._reativar_areas()
	player._reativar_sons()

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
		TransiçãoGlobal._animacao_fade_out()
		GlobalAudio._fadeOut(oficialMusic, 6.0)
		await get_tree().create_timer(2.3).timeout
		get_tree().change_scene_to_file("res://JumpOfThePigeon/Worlds/World1/Levels/level2/level2.tscn")
	pass 
