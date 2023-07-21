#version 460
#include <flutter/runtime_effect.glsl>

uniform float iTime;
uniform vec2 iResolution;
uniform sampler2D cloud_sample;
uniform sampler2D n_sample;

out vec4 fragColor;

vec3 white = vec3(1.0); //white
vec3 black = vec3(0.0); //black

vec3 palette( in float t, in vec3 a, in vec3 b, in vec3 c, in vec3 d )
{
    return a + b*cos( 6.28318*(c*t+d) );
}

/* discontinuous pseudorandom uniformly distributed in [-0.5, +0.5]^3 */
vec3 random3(vec3 c) {
    float j = 4096.0*sin(dot(c,vec3(17.0, 59.4, 15.0)));
    vec3 r;
    r.z = fract(512.0*j);
    j *= .125;
    r.x = fract(512.0*j);
    j *= .125;
    r.y = fract(512.0*j);
    return r-0.5;
}

/* skew constants for 3d simplex functions */
const float F3 =  0.3333333;
const float G3 =  0.1666667;

/* 3d simplex noise */
float simplex3d(vec3 p) {
/* 1. find current tetrahedron T and it's four vertices */
/* s, s+i1, s+i2, s+1.0 - absolute skewed (integer) coordinates of T vertices */
/* x, x1, x2, x3 - unskewed coordinates of p relative to each of T vertices*/

/* calculate s and x */
    vec3 s = floor(p + dot(p, vec3(F3)));
    vec3 x = p - s + dot(s, vec3(G3));

/* calculate i1 and i2 */
    vec3 e = step(vec3(0.0), x - x.yzx);
    vec3 i1 = e*(1.0 - e.zxy);
    vec3 i2 = 1.0 - e.zxy*(1.0 - e);

/* x1, x2, x3 */
    vec3 x1 = x - i1 + G3;
    vec3 x2 = x - i2 + 2.0*G3;
    vec3 x3 = x - 1.0 + 3.0*G3;

/* 2. find four surflets and store them in d */
    vec4 w, d;

/* calculate surflet weights */
    w.x = dot(x, x);
    w.y = dot(x1, x1);
    w.z = dot(x2, x2);
    w.w = dot(x3, x3);

/* w fades from 0.6 at the center of the surflet to 0.0 at the margin */
    w = max(0.6 - w, 0.0);

/* calculate surflet components */
    d.x = dot(random3(s), x);
    d.y = dot(random3(s + i1), x1);
    d.z = dot(random3(s + i2), x2);
    d.w = dot(random3(s + 1.0), x3);

/* multiply d by w^4 */
    w *= w;
    w *= w;
    d *= w;

/* 3. return the sum of the four surflets */
    return dot(d, vec4(52.0));
}

/* const matrices for 3d rotation */
const mat3 rot1 = mat3(-0.37, 0.36, 0.85,-0.14,-0.93, 0.34,0.92, 0.01,0.4);
const mat3 rot2 = mat3(-0.55,-0.39, 0.74, 0.33,-0.91,-0.24,0.77, 0.12,0.63);
const mat3 rot3 = mat3(-0.71, 0.52,-0.47,-0.08,-0.72,-0.68,-0.7,-0.45,0.56);

/* directional artifacts can be reduced by rotating each octave */
float simplex3d_fractal(vec3 m) {
    return   0.5333333*simplex3d(m*rot1)
    +0.2666667*simplex3d(2.0*m*rot2)
    +0.1333333*simplex3d(4.0*m*rot3)
    +0.0666667*simplex3d(8.0*m);
}


float calcAlpha(vec2 uv) {
    vec2 uv2 = vec2(uv.x -0.5, uv.y - 0.5);
    return 0.1;
}

float grayScale(vec4 s) {
    return 0.21 * s.r + 0.71 * s.g + 0.07 * s.b;
}

vec3 calcColor(float f3) {
    vec3 a = vec3(1.028, -0.082, 1.028);
    vec3 b = vec3(1.668, -1.172, 0.338);
    vec3 c = vec3(-0.802, 0.028, 0.248);
    vec3 d = vec3(2.668, 0.558, -0.392);

    vec3 col = palette(f3, a, b, c, d);

    return col ;
}

void main() {
    vec2 fragCoord = FlutterFragCoord().xy;
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    vec3 p3 = vec3(uv, iTime*0.25);

    float grayScale = grayScale( texture(cloud_sample, uv));
    float sf = simplex3d_fractal(p3) * 0.6 + 0.4;
    sf *= smoothstep(0.0, 0.005, abs(uv.x));
    vec4 cl0 = texture(n_sample, uv.yx);
    vec3 cl = cl0.xyz * grayScale * sf;
    // Output to screen
    fragColor = vec4(cl, 1.0);
}