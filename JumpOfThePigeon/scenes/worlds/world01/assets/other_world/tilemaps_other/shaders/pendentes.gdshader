shader_type canvas_item;

uniform float amplitude : hint_range(0.0, 30.0) = 8.0;
uniform float speed     : hint_range(0.0, 5.0)  = 1.2;
uniform float stiffness : hint_range(0.0, 1.0)  = 0.6;

// =========================
// COR DA NOITE
// =========================

uniform vec3 cor_noite : source_color = vec3(0.01, 0.03, 0.35);
uniform float intensidade : hint_range(0.0, 1.0) = 0.9;
uniform float brilho : hint_range(0.0, 2.0) = 0.8;


// =========================
// MOVIMENTO
// =========================

void vertex() {
    float sway_factor = UV.y * UV.y * (1.0 - stiffness);

    // Usa VERTEX local
    float tile_seed = dot(
        floor(VERTEX / 16.0 + 0.5),
        vec2(127.1, 311.7)
    );

    // Hash barata
    float h1 = fract(tile_seed * 0.1031);
    float h2 = fract(
        (tile_seed + 7.0) * 0.1031 + h1
    );

    float tile_phase = h1 * TAU;
    float freq_variation = 0.7 + h2 * 0.6;

    float t = TIME * speed * freq_variation;

    // Movimento principal
    float wave = sin(t + tile_phase);

    // Movimento secundário
    float wave2 = sin(
        t * 1.7 + tile_phase + 1.2
    ) * 0.3;

    // Movimento horizontal
    VERTEX.x +=
        (wave + wave2)
        * amplitude
        * sway_factor;

    // Leve movimento vertical
    VERTEX.y +=
        abs(wave)
        * amplitude
        * sway_factor
        * 0.05;
}


// =========================
// EFEITO NOTURNO
// =========================

void fragment() {
    vec4 tex = texture(TEXTURE, UV);

    // Calcula a luminância original
    float luminancia = dot(
        tex.rgb,
        vec3(0.299, 0.587, 0.114)
    );

    // Converte a luminância para azul noturno
    vec3 resultado =
        cor_noite
        * luminancia
        * brilho;

    // Mistura a textura original com a versão noturna
    resultado = mix(
        tex.rgb,
        resultado,
        intensidade
    );

    // Mantém o alpha original
    COLOR = vec4(
        resultado,
        tex.a
    );
}