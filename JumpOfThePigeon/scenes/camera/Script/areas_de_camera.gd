extends Node2D

@onready var camera = $"../player/camera"

func _on_zona_01_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		GlobalCameraConfig.zoom_camera(camera, 1.3, 1.3)
		GlobalCameraConfig.move_camera_y(camera, -30)
	pass # Replace with function body.


func _on_zona_02_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		GlobalCameraConfig.move_camera_x(camera, 100)
		GlobalCameraConfig.zoom_camera(camera, 1.0, 1.0)
	pass
