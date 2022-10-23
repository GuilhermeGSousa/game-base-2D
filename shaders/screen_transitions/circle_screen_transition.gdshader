shader_type canvas_item;

uniform vec4 in_color:source_color;
uniform vec4 out_color:source_color;

uniform float in_out:hint_range(0.,1.)=0.;

uniform float position:hint_range(-1.5,1.) = 0.856;
uniform vec2 size = vec2(16., 16.);

void fragment(){
    vec2 a = (1./SCREEN_PIXEL_SIZE) / size;
    
    vec2 uv=UV;
    uv *= a;
    
    vec2 i_uv = floor(uv);
    vec2 f_uv = fract(uv);
    
    float wave = max(0.,i_uv.x/(a.x) - position);
    
    vec2 center = f_uv*2.-1.;
    float circle = length(center);
    circle = 1. - step(wave,circle);
    
    vec4 color = mix(in_color, out_color, step(0.5, in_out));
    
    COLOR=vec4(circle) * color;
}