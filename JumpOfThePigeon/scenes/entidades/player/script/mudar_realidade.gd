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
