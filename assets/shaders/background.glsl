#version 460
#include <flutter/runtime_effect.glsl>

uniform float iTime;
uniform vec2 iResolution;
uniform sampler2D glx_sample;

out vec4 fragColor;

vec3 white = vec3(1.0); //white
vec3 black = vec3(0.0); //black

vec3 palette( in float t, in vec3 a, in vec3 b, in vec3 c, in vec3 d )
{
    return a + b*cos( 6.28318*(c*t+d) );
}

void calcMask(in vec2 uv, out vec3 inMask, out vec3 outMask) {
    float a = sin((uv.y + iTime) * 3.0)*0.25;
    float d = abs(uv.x*10.0 - a);

    vec3 col = mix(black, white, d);
    col -= mix(white, black, abs(uv.x));
    col = abs(col) * 0.25;
    outMask = col;
    inMask = 1.0 - col;
}

vec2 random2(vec2 st){
    st = vec2( dot(st,vec2(127.1,311.7)),
               dot(st,vec2(269.5,183.3)) );
    return -1.0 + 2.0*fract(sin(st)*43758.129);
}

// Gradient Noise by Inigo Quilez - iq/2013
// https://www.shadertoy.com/view/XdXGW8
float noise(vec2 st) {
    vec2 v = st + (sin(iTime));
    vec2 i = floor(v);
    vec2 f = fract(v);

    vec2 u = f*f*(3.0-2.0*f);

    return mix( mix( dot( random2(i + vec2(0.0,0.0) ), f - vec2(0.0,0.0) ),
                     dot( random2(i + vec2(1.0,0.0) ), f - vec2(1.0,0.0) ), u.x),
                mix( dot( random2(i + vec2(0.0,1.0) ), f - vec2(0.0,1.0) ),
                     dot( random2(i + vec2(1.0,1.0) ), f - vec2(1.0,1.0) ), u.x), u.y);
}

vec3 calcColor1(vec2 uv, vec3 inMask) {
    vec3 a = vec3(0.808, 0.858, 3.138);
    vec3 b = vec3(-0.290, 0.168, 0.000);
    vec3 c = vec3(1.000, 1.000, 0.500);
    vec3 d = vec3(1.000, 0.500, 0.250);

    vec3 col = palette(inMask.x, a, b, c, d);

    return col * inMask;
}

vec3 calcColor2(vec2 uv, vec3 outMask) {
    vec3 a = vec3(0.748, 0.858, 0.968);
    vec3 b = vec3(0.000, 0.168, 0.108);
    vec3 c = vec3(0.000, 0.698, -1.192);
    vec3 d = vec3(0.000, -0.332, -1.442);

    float f = noise(uv);
    float f2 = noise(uv + 0.1);
    float f3 = noise(vec2(f,f2));

    vec3 col = palette(f3, a, b, c, d);

    vec2 uv2 = abs(vec2(uv.x +0.5, uv.y) * 2 - 1);

    col = col * 0.7 + texture(glx_sample, uv2).xyz * 0.3;

    return col * outMask;
}

void main() {
    vec2 fragCoord = FlutterFragCoord().xy;
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    uv = vec2(uv.x - 0.5, uv.y);
    // Time varying pixel color
    vec3 col = vec3(0.0);

    vec3 inMask;
    vec3 outMask;

    calcMask(uv, inMask, outMask);

    col += calcColor1(uv, inMask);
    col += calcColor2(uv, outMask);

    // Output to screen
    fragColor = vec4(col,1.0);
}