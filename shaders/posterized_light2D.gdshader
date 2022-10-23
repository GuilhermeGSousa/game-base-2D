shader_type canvas_item;

uniform float posterization_level;

void light()
{
	vec4 light_color = LIGHT_COLOR * LIGHT_ENERGY;
	float light_scale = light_color.a;
	
	float level = floor(light_scale * posterization_level) / posterization_level;

	float adjustment = level / light_scale;
	
	vec4 posterized_color = COLOR * light_color * adjustment;
	LIGHT = vec4(posterized_color.rgb, LIGHT_COLOR.a);
}
