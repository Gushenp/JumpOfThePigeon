extends Node

var esta_no_normal := true
@onready var normalMAP = $normalMAP
@onready var otherMAP = $otherMAP

func _ready() -> void:
	GlobalTransition.animation_fade_in()
	alterar_mundo_outro(true)

func _process(_delta: float) -> void:
	_mudar_realidade()


func _mudar_realidade() -> void:
	if Input.is_action_just_pressed("change"):
		esta_no_normal = !esta_no_normal
		
		alterar_mundo_normal(esta_no_normal)
		alterar_mundo_outro(esta_no_normal)


func alterar_mundo_normal(esta_no_normal) -> void:
	if esta_no_normal:
		normalMAP.visible = true
		print("Normal: VISÍVEL")

	else:
		normalMAP.visible = false
		print("Normal: OCULTO")


func alterar_mundo_outro(esta_no_normal) -> void:
	if esta_no_normal:
		# Altera o mapa
		otherMAP.visible = false
		otherMAP.get_node("other_tilemap/solo").collision_enabled = false
		
		# Alterar os inimigos 
		for espreitador in get_tree().get_nodes_in_group("espreitadores"):
			espreitador.mudar_realidade_normal()
			
		print("outro: OCULTO")
	else:
		otherMAP.visible = true
		otherMAP.get_node("other_tilemap/solo").collision_enabled = true
		
		# Alterar os inimigos
		for espreitador in get_tree().get_nodes_in_group("espreitadores"):
			espreitador.mudar_realidade_outro()

		print("Outro: VISÍVEL")
	pass
	
