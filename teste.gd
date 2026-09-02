extends Node2D

@onready var shader_material = $CanvasLayer/ColorRect.material
var other = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudiopapkinForestAmbience296528.play()
	$DragonStudioCreepyIndustrialSoundsAmbience482892.play()
	$DragonStudioCreepyIndustrialSoundsAmbience482892.stream_paused = true
	$FreesoundCommunityFmbient22575.play()
	mudarRealidade()
	mudarRealidade()
	$espreitador.kill_player.connect(eliminar)
	$player.change_reality.connect(mudarRealidade)
	start_game()
	pass 
	
func start_game():
	$player.desativar_player()
	GlobalTransition.animation_fade_in()
	await get_tree().create_timer(1.5).timeout
	$player.reativar_player()
	pass

func morreu_vadia():
	$player.eliminar_player()

func mudarRealidade():
	iniciar_distorcao()
	if other == false:
		$espreitador.mudar_realidade()
		$espreitador2.mudar_realidade()
		$DragonStudioCreepyIndustrialSoundsAmbience482892.stream_paused = false
		$AudiopapkinForestAmbience296528.stream_paused = true
		$otherMap.visible = true
		$normalMap.visible = false
		$FreesoundCommunityFmbient22575.pitch_scale = 0.84
		$otherMap/Node2D.layer = -1
		$normalMap/Node2D.layer = -2
		
		other = true
	else:
		$espreitador.mudar_realidade()
		$espreitador2.mudar_realidade()
		$DragonStudioCreepyIndustrialSoundsAmbience482892.stream_paused = true
		$FreesoundCommunityFmbient22575.stream_paused = false
		$AudiopapkinForestAmbience296528.stream_paused = false
		$FreesoundCommunityFmbient22575.pitch_scale = 1.0
		$otherMap.visible = false
		$normalMap.visible = true
		$otherMap/Node2D.layer = -2
		$normalMap/Node2D.layer = -1
		other = false

func iniciar_distorcao():
	var tween = create_tween()

	# Distorção aparece muito rápido
	tween.tween_method(
		func(valor):
			shader_material.set_shader_parameter("intensity", valor),
		0.0,
		0.035,
		0.04
	)

	# Flash
	tween.parallel().tween_method(
		func(valor):
			shader_material.set_shader_parameter("flash", valor),
		0.0,
		0.35,
		0.025
	)

	# Flash desaparece
	tween.tween_method(
		func(valor):
			shader_material.set_shader_parameter("flash", valor),
		0.35,
		0.0,
		0.06
	)

	# Distorção desaparece
	tween.parallel().tween_method(
		func(valor):
			shader_material.set_shader_parameter("intensity", valor),
		0.035,
		0.0,
		0.10
	)
	
func eliminar():
	$player.eliminar_player()


func _on_zona_01_body_entered(body: Node2D) -> void:
	GlobalCameraConfig.move_camera_x($camera, 350)
	GlobalCameraConfig.move_camera_y($camera, 20)
	pass # Replace with function body.
