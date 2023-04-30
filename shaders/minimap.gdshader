shader_type canvas_item;

uniform vec4 color : source_color;
uniform vec4 background_color : source_color;

void fragment() {
	vec4 c = texture(TEXTURE, UV);
	
	if(c.a != 1.0)
	{
		COLOR = background_color;
	}
	else
	{
		COLOR = color;
	}
}
