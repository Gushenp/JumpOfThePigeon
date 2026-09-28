shader_type canvas_item;

// =========================
// MOVIMENTO DA GRAMA
// =========================

uniform float amplitude : hint_range(0.0, 20.0) = 5.0;
uniform float speed     : hint_range(0.0, 5.0)  = 1.5;
uniform float stiffness : hint_range(0.0, 1.0)  = 0.5;


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
    // Grama na parede vertical:
    // UV.x = 0 → parte presa na parede
    // UV.x = 1 → ponta livre

    float sway_factor =
        UV.x * UV.x * (1.0 - stiffness);

    // Hash por tile
    float tile_seed = dot(
        floor(VERTEX / 16.0 + 0.5),
        vec2(127.1, 311.7)
    );

    float h1 = fract(tile_seed * 0.1031);
    float h2 = fract(
        (tile_seed + 7.0) * 0.1031 + h1
    );

    float tile_phase = h1 * TAU;
    float freq_variation = 0.7 + h2 * 0.6;

    float t =
        TIME * speed * freq_variation;

    // Movimento principal
    float wave =
        sin(t + tile_phase);

    // Movimento secundário
    float wave2 =
        sin(t * 1.6 + tile_phase + 0.9) * 0.25;

    // Movimento vertical
    VERTEX.y +=
        (wave + wave2)
        * amplitude
        * sway_factor;

    // Pequena compressão horizontal
    VERTEX.x +=
        abs(wave)
        * amplitude
        * sway_factor
        * 0.04;
}


// =========================
// EFEITO NOTURNO
// =========================

void fragment() {
    vec4 tex = texture(TEXTURE, UV);

    // Calcula a luminosidade original
    float luminancia = dot(
        tex.rgb,
        vec3(0.299, 0.587, 0.114)
    );

    // Cria a versão azul da textura
    vec3 resultado =
        cor_noite
        * luminancia
        * brilho;

    // Mistura original com a versão noturna
    resultado = mix(
        tex.rgb,
        resultado,
        intensidade
    );

    // Mantém a transparência
    COLOR = vec4(
        resultado,
        tex.a
    );
}