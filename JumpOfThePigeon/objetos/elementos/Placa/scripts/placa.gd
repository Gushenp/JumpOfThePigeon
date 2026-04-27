extends CharacterBody2D

signal talk_placa

# === import nodes =====
@onready var animations = $animations
@onready var animation_placa = $animations_placa
@onready var animation_botao = $animations_botao
@onready var dialog_box= $"dialog box"
@onready var node = $"."

# ==== control variables ====
@onready var gravidade = 986.0
var is_active = false
var gravidade_ativada = true

func _ready() -> void:
	animations_sing()
	pass 

func _process(delta: float) -> void:
	_gravity(delta)
	move_and_slide()

# ==== entered and exited ====
func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body is CharacterBody2D:
		is_active = true
		animations_sing()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		is_active = false
		animations_sing()

# ==== body changes=====
func _gravity(delta):
	if not is_on_floor() and gravidade_ativada:
		velocity.y += gravidade * delta
		sounds_to_land()
		
func jump():
	if is_on_floor() and gravidade_ativada:
		velocity.y = -230

func animations_sing():
	if is_active: 
		jump()
		sounds_talk()
		animations.play("talk")
		animation_placa.play("surgir_placa")
		animations_button()
	else: 
		animations.stop()
		animation_placa.play("sumir_placa")
		get_tree().create_timer(0.2).timeout
		animation_botao.stop()
		
func animations_button():
	if is_active:
		if node.name == "frog plate":
			animation_botao.play("pressionar_botao")
		elif node.name == "frog plate2":
			animation_botao.play("pressionar_duplo_botao")
		elif node.name == "frog plate3":
			animation_botao.play("pressionar_e_segurar")
	
func sounds_talk():
	var sounds = [
		$sounds/Nha1,
		$sounds/Nha2,
		$sounds/Nha3
	]
	var som_aleatorio = sounds.pick_random()
	som_aleatorio.play()
	
func sounds_to_land():
	$sounds/Aterrisar.play()
	$sounds/AterrisarAmbiente.play()

# == external commands ==

func ed_gravity(value:bool):
	if value:
		gravidade_ativada = true
	else:
		gravidade_ativada = false
