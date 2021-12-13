uniform mat4 transform;

attribute vec4 position;
attribute vec4 color;
attribute vec2 texCoord;

varying vec4 rgb;
varying vec2 uv;


void main() {
  gl_Position = transform * position;
  rgb = color;
  uv = texCoord;
}
