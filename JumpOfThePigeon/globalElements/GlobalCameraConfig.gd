extends Node2D

var move_tween_x
var move_tween_y

func move_camera_x(camera, alvoX):
	if move_tween_x:
		move_tween_x.kill()
	
	move_tween_x = create_tween()
	move_tween_x.tween_property(camera, "offset:x", alvoX, 0.5)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)
		

func move_camera_y(camera, alvoY):
	if move_tween_y:
		move_tween_y.kill()
		
	move_tween_y = create_tween()
	move_tween_y.tween_property(camera, "offset:y", alvoY, 0.5)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)

func zoom_camera(camera, alvoX, alvoY):
	var tween = create_tween()
	tween.tween_property(camera, "zoom", Vector2(alvoX, alvoY), 0.5)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)
		
