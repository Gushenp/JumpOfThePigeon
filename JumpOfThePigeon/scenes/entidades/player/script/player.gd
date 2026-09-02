extends CharacterBody2D

#Variáveis fundamentais
@onready var player = self

#arquivos externos
@onready var animacaoPlayerFrame = $AnimatedSprite2D
@onready var jump_sound = $Audio/Jump
@onready var aterrisar_sound = $Audio/Aterrisar
@onready var aterrisar_ambiente = $Audio/AterrisarAmbiente
@onready var walking_sound = $Audio/Walking
@onready var flying_sound = $Audio/Flying
@onready var camera = $camera

#variáveis de controle
@export var SPEED:float = 120.0
@export var JUMP_VELOCITY_PRIMARY:float = -300
@export var JUMP_VELOCITY_SECONDARY:float = -300
@export var posicao_inicial : Vector2

# Variáveis internas
var player_ativo = true
var is_death = false
var gravidade = 986.0
var gravidade_planando = 200.0
var is_control_active = true


# ====== Processos iniciais ========
func _ready() -> void:
	posicao_inicial = player.global_position

# ===== Processo de Quadros ======
func _physics_process(delta: float) -> void:
	_controle_de_atividade(delta)

# ===== Funções de Estados =====
func _controle_de_atividade(delta):
	if player_ativo:
		_player_controls()
		_gravity(delta)
		move_and_slide()
	else:
		return 
		
# ===== Funções Gerais =====
func _player_controls():
	if is_control_active:
		_player_jump()
		_player_direction()
		_animacao_player()
		_player_change_reality()
		_audio_player()
	else:
		return

# ===== Adicionar Gravidade =====
func _gravity(delta):
	if not is_on_floor():
		if Input.is_action_pressed("jump") and velocity.y > 0 and pulos_restantes == 0:
			velocity.y += gravidade_planando * delta
		else: 
			velocity.y += gravidade * delta
	else:
		velocity.y += 0

# ===== Funções de Pulo ======
@export var pulos_restantes = 0
func _player_jump():
	if is_on_floor():
		pulos_restantes = 2
	if Input.is_action_just_pressed("jump") and pulos_restantes > 0:
		if pulos_restantes == 2:
			_random_pitch_audio()
			jump_sound.play(3.21)
			velocity.y = JUMP_VELOCITY_PRIMARY
		elif pulos_restantes <= 1:
			_random_pitch_audio()
			jump_sound.play()
			velocity.y = JUMP_VELOCITY_SECONDARY
		pulos_restantes -= 1

# ====== Movimentação Player =======
func _player_direction():
	if is_death:
		return
		
	var direction := Input.get_axis("left", "right")
	velocity.x = direction * SPEED if direction != 0 else move_toward(velocity.x, 0, SPEED)

# ======= Mudar de Realidade =======
signal change_reality
func _player_change_reality():
	if Input.is_action_just_pressed("change"):
		emit_signal("change_reality")
		
		var audios = [$Audio/alterarRealidade/Piu00, $Audio/alterarRealidade/Piu01, $Audio/alterarRealidade/Piu02]
		var audio_escolhido = audios.pick_random()
		audio_escolhido.play()
		$Audio/Freeze.play()

# ======= animações ==========
func _animacao_player():
	if is_death == false:
		if not player.is_on_floor():
			if Input.is_action_just_pressed("jump"):
				animacaoPlayerFrame.play("pular")
		
		#Animação de pulo
		if not player.is_on_floor() and Input.is_action_pressed("jump") and pulos_restantes == 0:
			animacaoPlayerFrame.play("fly")
				
		#Animação de controles
		if player.is_on_floor():
			if Input.is_action_just_pressed("jump"):
				animacaoPlayerFrame.play("pular")
			else: 
				if Input.is_action_pressed("right"):
					animacaoPlayerFrame.flip_h = 0
					animacaoPlayerFrame.play("walk")
				elif  Input.is_action_pressed("left"):
					animacaoPlayerFrame.flip_h = 1
					animacaoPlayerFrame.play("walk")
				else: 
					animacaoPlayerFrame.play("stay")
		else:
			if Input.is_action_pressed("right"):
				animacaoPlayerFrame.flip_h = 0
			elif  Input.is_action_pressed("left"):
				animacaoPlayerFrame.flip_h = 1
				
# Tremer camera
func tremer_camera():
	var offset_original = camera.offset
	
	camera.offset = offset_original + Vector2(2.0, 2.0)
	await get_tree().create_timer(0.04).timeout
	
	camera.offset = offset_original + Vector2(-2.0, -2.0)
	await get_tree().create_timer(0.04).timeout
	
	camera.offset = offset_original + Vector2(1.0, 1.0)
	await get_tree().create_timer(0.5).timeout
	
	camera.offset = offset_original

# ====== audios player ============
var estava_no_chao = false
func _audio_player():
	#aterrisagem no chão
	var no_chao_agora = is_on_floor()
	if not estava_no_chao and no_chao_agora:
		aterrisar_sound.play(0.21)
		aterrisar_ambiente.play(0.10)
	estava_no_chao = no_chao_agora
	
# ======= coloar pitch aleatório dos efeitos ======
func _random_pitch_audio():
	jump_sound.pitch_scale = randf_range(0.8, 1.8)
	aterrisar_sound.pitch_scale = randf_range(0.8, 1.1)
	aterrisar_ambiente.pitch_scale = randf_range(0.9, 1.1)

# ======= eliminar player =======
func eliminar_player():
	_apply_death()
	await get_tree().create_timer(2.0).timeout
	get_tree().reload_current_scene()
	
func _apply_death():	
	tremer_camera()
	player.rotation_degrees = 180
	var direction_player = (global_position).normalized()
	var direction = Input.get_axis("left", "right")
	
	is_death = true
	desativar_colisoes()
	GlobalTransition.animation_fade_out()
	
	velocity.y = -400
	if direction == 1.0:
		velocity.x = direction_player.x * -100
	elif direction == -1.0:
		velocity.x = direction_player.x * 100
		
	player.z_index = 10
	animacaoPlayerFrame.play("death")

#==================================
# ==== Desativar e ativar funcionalidades player ====
#==================================
func desativar_player():
	player_ativo = false

func reativar_player():
	player_ativo = true
	
func desativar_colisoes():
	$CollisionShape2D.queue_free()
	
func desatvar_controles():
	is_control_active = false
