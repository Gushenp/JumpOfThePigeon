extends CharacterBody2D


#sinais
signal kill_player

# Externo
@onready var animacao = $AnimatedSprite2D

# Variáveis de controle
@export var GRAVITY := 986.0
@export var distancia_max_direita := 200.0
@export var distancia_max_esquerda := 200.0
@export var SPEED := 20.0

var posicao_inicial: float
var direcao := 1.0
var esperando = null
var other = false

func _ready() -> void:
	posicao_inicial = global_position.x


func _physics_process(delta: float) -> void:
	_gravity(delta)
	_caminhar()
	move_and_slide()


func _gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta


func _caminhar() -> void:
	
	if esperando and other == false:
		velocity.x = 0
		$AnimatedSprite2D.play("ficar")
		return
	
	var limite_direita = posicao_inicial + distancia_max_direita
	var limite_esquerda = posicao_inicial - distancia_max_esquerda

	#Atuação de colisões
	if $RayCastEsquerda.is_colliding() or not $RayCastbordaEsquerda.is_colliding() :
		direcao = 1
		esperando = true
		
		if other == false:
			esperando = true
			$Timer.start()
		
		if other == true:
			esperando = false
			$AnimatedSprite2D.flip_h = true
		
	if	$RayCastDireita.is_colliding() or not $RayCastbordaDireita.is_colliding():
		direcao = -1
		if other == false:
			esperando = true
			$Timer.start()
		
		if other:
			esperando = false
			$AnimatedSprite2D.flip_h = false
	
	# Chegou no limite da direita
	if global_position.x >= limite_direita:
		direcao = -1.0
		esperando = true
		$Timer.start()
		
	# Chegou no limite da esquerda
	elif global_position.x <= limite_esquerda:
		direcao = 1.0
		esperando = true
		$Timer.start()

	velocity.x = direcao * SPEED
	$AnimatedSprite2D.play("andar")

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
	
	
func mudar_realidade():
	if other:
		SPEED = SPEED / 4
		$".".modulate = "#ffffff"
		$AnimatedSprite2D.speed_scale = 1.0
		$PointLight2D.visible = false
		other = false
	else: 
		SPEED = SPEED * 4
		$".".modulate = Color(0.0, 0.654, 1.041)
		$PointLight2D.visible = true
		$AnimatedSprite2D.speed_scale = 1.5
		other = true
		
