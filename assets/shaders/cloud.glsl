#version 460
#include <flutter/runtime_effect.glsl>

uniform float iTime;
uniform vec2 iResolution;
uniform sampler2D cloud_sample;

out vec4 fragColor;

vec3 white = vec3(1.0); //white
vec3 black = vec3(0.0); //black


void main() {
    vec2 fragCoord = FlutterFragCoord().xy;
    // Normalized pixel coordinates (from 0 to 1)

    // Output to screen
    fragColor = vec4(1.0);
}