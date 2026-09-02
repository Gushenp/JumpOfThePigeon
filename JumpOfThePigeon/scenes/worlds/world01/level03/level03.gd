extends Node2D

@onready var camera = $player/camera

func _ready() -> void:
	
	var espreitadores = get_tree().get_nodes_in_group("espreitadores")
	for espreitador in espreitadores:
		espreitador.kill_player.connect(eliminar_player)
	
	start_game()
	pass 
	
func start_game():
	$player.desativar_player()
	GlobalTransition.animation_fade_in()
	await get_tree().create_timer(1.5).timeout
	$player.reativar_player()
	pass

func eliminar_player():
	$player.eliminar_player()
