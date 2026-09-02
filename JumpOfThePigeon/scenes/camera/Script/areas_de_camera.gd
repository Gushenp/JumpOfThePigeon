extends Node2D


func _on_zona_01_area_entered(area: Area2D) -> void:
	GlobalCameraConfig.zoom_camera($"../player/camera", 1.2, 1.2)
	pass 


func _on_zona_02_area_entered(area: Area2D) -> void:
	GlobalCameraConfig.zoom_camera($"../player/camera", 1.4, 1.4)
	GlobalCameraConfig.move_camera_x($"../player/camera", 100)
	pass # Replace with function body.


func _on_zona_03_area_entered(area: Area2D) -> void:
	GlobalCameraConfig.zoom_camera($"../player/camera", 1.2, 1.2)
	GlobalCameraConfig.move_camera_x($"../player/camera", 150)
	GlobalCameraConfig.move_camera_y($"../player/camera", -20)
	pass # Replace with function body.


func _on_zona_04_area_entered(area: Area2D) -> void:
	GlobalCameraConfig.zoom_camera($"../player/camera", 1.5, 1.5)
	GlobalCameraConfig.move_camera_x($"../player/camera", 0)
	GlobalCameraConfig.move_camera_y($"../player/camera", 0)
	pass # Replace with function body.
