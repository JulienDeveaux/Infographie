uniform mat4 transform;

attribute vec4 position;
attribute vec4 color;
attribute vec3 normal;
attribute vec2 texCoord;


varying vec4 vertColor;
varying vec3 n;
varying vec2 uv;


void main() {
  gl_Position = transform * position;  
  vertColor = color;
  n = normal;
  uv = texCoord;
}
