#version 460
#include <flutter/runtime_effect.glsl>

uniform vec2 iResolution;

out vec4 fragColor;


void main() {
    vec2 fragCoord = FlutterFragCoord().xy;
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    uv = vec2(uv.x - 0.5, uv.y);
    // Time varying pixel color
    //vec3 col = 0.5 + 0.5*cos(iTime+uv.xyx+vec3(0,2,4));

    float a = sin(uv.y * 10.0)*0.25;
    float d = abs(uv.x*10.0 - a);

    vec3 white = vec3(1.0); //white
    vec3 black = vec3(0.0); //black

    vec3 col = mix(black, white, d);
    col -= mix(white, black, abs(uv.x));
    col = col * 0.25;
    // Output to screen
    fragColor = vec4(col,1.0);
}