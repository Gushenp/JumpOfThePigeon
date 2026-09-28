shader_type canvas_item;

uniform vec3 cor_noite : source_color = vec3(0.01, 0.03, 0.35);
uniform float intensidade : hint_range(0.0, 1.0) = 0.9;
uniform float brilho : hint_range(0.0, 2.0) = 0.8;

void fragment() {
    vec4 tex = texture(TEXTURE, UV);

    float luminancia = dot(tex.rgb, vec3(0.299, 0.587, 0.114));

    vec3 resultado = cor_noite * luminancia * brilho;

    resultado = mix(tex.rgb, resultado, intensidade);

    COLOR = vec4(resultado, tex.a);
}