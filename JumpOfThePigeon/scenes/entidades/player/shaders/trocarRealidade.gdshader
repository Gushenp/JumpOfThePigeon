shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear;

uniform float intensity : hint_range(0.0, 0.1) = 0.0;
uniform float blocks : hint_range(5.0, 100.0) = 40.0;
uniform float speed : hint_range(1.0, 60.0) = 30.0;
uniform float flash : hint_range(0.0, 1.0) = 0.0;

float random(vec2 uv) {
	return fract(sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment() {
	vec2 uv = SCREEN_UV;

	// Grade de fragmentação
	vec2 grid = floor(uv * blocks);

	// Movimento aleatório dos fragmentos
	float noise = random(grid + floor(TIME * speed));

	// Fragmentos horizontais
	if (noise > 0.55) {
		uv.x += (noise - 0.55) * intensity * 2.0;
	}

	if (noise < 0.35) {
		uv.x -= (0.35 - noise) * intensity * 2.0;
	}

	// Alguns fragmentos também sobem/descem
	if (noise > 0.80) {
		uv.y += intensity * 0.8;
	}

	if (noise < 0.15) {
		uv.y -= intensity * 0.8;
	}

	// Pequena distorção ondulada
	uv.x += sin(uv.y * 35.0 + TIME * 20.0) * intensity * 0.25;

	vec4 screen = texture(screen_texture, uv);

	// Flash branco
	screen.rgb += flash;

	COLOR = screen;
}