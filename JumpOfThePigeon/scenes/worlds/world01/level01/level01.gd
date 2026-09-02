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

# Funções de Câmera
func _on_zona_01_area_entered(area: Area2D) -> void:
	GlobalCameraConfig.zoom_camera(camera, 1.6, 1.6)
	pass 


func _on_zona_02_area_entered(area: Area2D) -> void:
	GlobalCameraConfig.move_camera_x(camera, 100)
	pass # Replace with function body.


func _on_zona_03_area_entered(area: Area2D) -> void:
	GlobalCameraConfig.zoom_camera(camera, 1.3, 1.3)
	pass # Replace with function body.


func _on_zona_04_area_entered(area: Area2D) -> void:
	GlobalCameraConfig.zoom_camera(camera, 2.0, 2.0)
	GlobalCameraConfig.move_camera_x(camera, 0)
	pass # Replace with function body.
	
