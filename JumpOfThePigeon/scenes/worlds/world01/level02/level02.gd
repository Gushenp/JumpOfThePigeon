extends Node2D

@onready var camera = $player/camera

func _ready() -> void:
	start_game()
	pass 
	
func start_game():
	$player.desativar_player()
	GlobalTransition.animation_fade_in()
	await get_tree().create_timer(1.5).timeout
	$player.reativar_player()
	pass
