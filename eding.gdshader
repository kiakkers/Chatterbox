shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture;

uniform float threshold = 0.2;
uniform float strength = 1.4;

void fragment() {

	vec2 texel = SCREEN_PIXEL_SIZE;

	vec3 c  = texture(screen_texture, SCREEN_UV).rgb;
	vec3 cx = texture(screen_texture, SCREEN_UV + vec2(texel.x,0.0)).rgb;
	vec3 cy = texture(screen_texture, SCREEN_UV + vec2(0.0,texel.y)).rgb;

	float diff = length(c - cx) + length(c - cy);

	float edge = step(threshold, diff);

	vec3 edge_color = c * strength;

	COLOR.rgb = mix(c, edge_color, edge);
	COLOR.a = 1.0;
}