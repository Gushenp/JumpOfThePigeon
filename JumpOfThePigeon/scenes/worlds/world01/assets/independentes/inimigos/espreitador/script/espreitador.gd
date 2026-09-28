extends CharacterBody2D


#sinais
signal kill_player
# Externo
@onready var animacao = $AnimatedSprite2D

# Variáveis de controle
@export var GRAVITY := 986.0
@export var distancia_max_direita := 200.0
@export var distancia_max_esquerda := 200.0
@export var SPEED := 200.0
var velocidade_base: float

var posicao_inicial: float
var direcao := 1.0
var esperando = null
var other = false

func _ready() -> void:
	posicao_inicial = global_position.x
	velocidade_base = SPEED


func _physics_process(delta: float) -> void:
	_gravity(delta)
	_caminhar()
	move_and_slide()


func _gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta


func _caminhar() -> void:
	if esperando and not other:
		velocity.x = 0
		animacao.play("ficar")
		return

	var limite_direita = posicao_inicial + distancia_max_direita
	var limite_esquerda = posicao_inicial - distancia_max_esquerda

	if direcao == 1:
		if global_position.x >= limite_direita:
			direcao = -1
			if other:
				esperando = false
			else:
				esperando = true
				$timer.start()

		elif $RayCastDireita.is_colliding():
			direcao = -1
			if other:
				esperando = false
			else:
				esperando = true
				$timer.start()

		elif not $RayCastbordaDireita.is_colliding():
			direcao = -1
			if other:
				esperando = false
			else:
				esperando = true
				$timer.start()
	else:
		if global_position.x <= limite_esquerda:
			direcao = 1
			if other:
				esperando = false
			else:
				esperando = true
				$timer.start()
		elif $RayCastEsquerda.is_colliding():
			direcao = 1
			if other:
				esperando = false
			else:
				esperando = true
				$timer.start()
		elif not $RayCastbordaEsquerda.is_colliding():
			direcao = 1
			if other:
				esperando = false
			else:
				esperando = true
				$timer.start()
				
	velocity.x = direcao * SPEED
	animacao.play("andar")
	if direcao == 1:
		animacao.flip_h = true
	else:
		animacao.flip_h = false

func _on_timer_timeout() -> void:
	esperando = false
	if direcao == 1: 
		$AnimatedSprite2D.flip_h = true
	else: 
		$AnimatedSprite2D.flip_h = false
	pass

func _on_kill_body_entered(body: Node2D) -> void:
	emit_signal("kill_player")
	pass # Replace with function body.
	
	
func mudar_realidade_normal():
	SPEED = velocidade_base 
	$".".modulate = "#ffffff"
	$AnimatedSprite2D.speed_scale = 1.0
	$PointLight2D.visible = false
	other = false

func mudar_realidade_outro():
	other = true
	SPEED = velocidade_base * 4
	$".".modulate = Color(0.0, 0.654, 1.041)
	$PointLight2D.visible = true
	$AnimatedSprite2D.speed_scale = 1.5
