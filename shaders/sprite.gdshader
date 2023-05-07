shader_type canvas_item;

// Sprite shake
uniform bool is_shaking = true;
uniform float amplitude = 1.0;

// Sprite flicker
uniform bool is_flickering = false;
uniform vec4 flicker_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float flicker_frequency = 1.0;

float random (vec2 uv) {
    return fract(sin(dot(uv.xy,
        vec2(12.9898,78.233))) * 43758.5453123);
}

void fragment() {
	float sin_time = sin(flicker_frequency * TIME * PI);
	
	if(is_flickering)
	{
		COLOR.rgb = sin_time > 0.0 ? COLOR.rgb : flicker_color.rgb;
	}	
}

void vertex()
{
	float time = TIME;
	
	float rand_x = random(vec2(time, time)) * 2.0 - 1.0;
	float rand_y = random(vec2(time + 1.0, time + 1.0)) * 2.0 - 1.0;
	
	float dx = is_shaking ? amplitude * rand_x : 0.0;
	float dy = is_shaking ? amplitude * rand_y : 0.0;
	VERTEX = vec2(VERTEX.x + dx, VERTEX.y + dy);
}