#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

varying vec4 rgb;
varying vec2 uv;

vec3 rgb2hsb( in vec3 c ){
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz),
                 vec4(c.gb, K.xy),
                 step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r),
                 vec4(c.r, p.yzx),
                 step(p.x, c.r));
    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)),
                d / (q.x + e),
                q.x);
}

vec3 hsb2rgb( in vec3 c ){
    vec3 rgbFonction = clamp(abs(mod(c.x*6.0+vec3(0.0,4.0,2.0),
                             6.0)-3.0)-1.0,
                     0.0,
                     1.0 );
    rgbFonction = rgbFonction*rgbFonction*(3.0-2.0*rgbFonction);
    return c.z * mix(vec3(1.0), rgbFonction, c.y);
}


void main() {
    vec4 color;

    color = vec4(hsb2rgb(vec3(uv.x, uv.y, 1)), 1);

    gl_FragColor = color;
}