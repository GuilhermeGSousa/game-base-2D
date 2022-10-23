shader_type canvas_item;

uniform bool is_flickering = true;
uniform vec4 flicker_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float flicker_frequency = 1.0;

void fragment() {
	float sin_time = sin(flicker_frequency * TIME * PI);
	
	if(is_flickering)
	{
		COLOR = sin_time > 0.0 ? COLOR : flicker_color;
	}
	
}