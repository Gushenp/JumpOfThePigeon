extends canvas_item

@export var energia_base := 1.0
@export var variacao := 0.2
@export var velocidade := 8.0

func _process(delta):
	var flicker = (
		sin(Time.get_ticks_msec() * 0.001 * velocidade) * 0.5 +
		sin(Time.get_ticks_msec() * 0.001 * velocidade * 2.3) * 0.3 +
		sin(Time.get_ticks_msec() * 0.001 * velocidade * 4.7) * 0.2
	)

	energy = energia_base + flicker * variacao