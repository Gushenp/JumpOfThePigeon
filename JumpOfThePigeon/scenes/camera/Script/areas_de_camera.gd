extends Node2D


func _on_zona_01_body_entered(body: Node2D) -> void:
	GlobalCameraConfig.move_camera_x($"../../player/camera", 100)
	GlobalCameraConfig.move_camera_y($"../../player/camera", -20)
	pass # Replace with function body.


func _on_zona_02_body_entered(body: Node2D) -> void:
	GlobalCameraConfig.move_camera_y($"../../player/camera", 50)
	pass # Replace with function body.


func _on_zona_03_body_entered(body: Node2D) -> void:
	GlobalCameraConfig.zoom_camera($"../../player/camera", 1.3, 1.3)
	pass # Replace with function body.


func _on_zona_04_body_entered(body: Node2D) -> void:
	GlobalCameraConfig.move_camera_y($"../../player/camera" ,-30)
	GlobalCameraConfig.move_camera_x($"../../player/camera", 200)
	pass # Replace with function body.


func _on_zona_05_body_entered(body: Node2D) -> void:
	GlobalCameraConfig.move_camera_x($"../../player/camera", 0)
	GlobalCameraConfig.move_camera_y($"../../player/camera", 0)
	GlobalCameraConfig.zoom_camera($"../../player/camera", 0, 0)
	pass # Replace with function body.
