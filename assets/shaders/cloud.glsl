#version 460
#include <flutter/runtime_effect.glsl>

uniform float iTime;
uniform vec2 iResolution;
uniform sampler2D cloud_sample;
uniform sampler2D glx_sample;

out vec4 fragColor;

vec3 white = vec3(1.0); //white
vec3 black = vec3(0.0); //black

float checkAndSetToZero(float inputValue, float threshold) {
    if (inputValue < threshold) {
        return 0.0;
    } else {
        return inputValue;
    }
}

float grayScale(vec4 s) {
    return 0.21 * s.r + 0.71 * s.g + 0.07 * s.b;
}

void main() {
    vec2 fragCoord = FlutterFragCoord().xy;
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;

    float grayScale = grayScale( texture(cloud_sample, uv));
    vec3 cl = texture(glx_sample, uv.yx).xyz * grayScale;
    // Output to screen
    fragColor = vec4(cl, 1.0);
}