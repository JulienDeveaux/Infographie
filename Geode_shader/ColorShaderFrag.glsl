#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

varying vec4 vertColor;
varying vec2 uv;
varying vec3 n;

void main() {
    vec4 color;

    color = mix(vertColor, vec4(vec3(1) - vertColor.xyz, 1), uv.x);
    color = mix(color, vec4(vertColor.bgr, 1), uv.y);
    gl_FragColor = vec4(n, 1);
}