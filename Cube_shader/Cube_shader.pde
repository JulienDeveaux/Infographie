float angle = 0f;

PShader colorShader;

void setup() {
  size(500, 500, P3D);
  
  colorShader = loadShader("ColorShaderFrag.glsl", "ColorshaderVert.glsl");
}

void draw() {
  background(0);
PShape cube = creerCube(100);
  shader(colorShader);
  translate(width/2,height/2,0);
  cube.translate(-25, -25, -25);
  cube.rotateX(20);
  cube.rotateY(angle);
  shape(cube);
  
  angle += 0.04;
}


PShape creerCube(float c) {
  PShape cube = createShape();
  cube.beginShape(QUADS);
    cube.fill(255, 0, 0);
    cube.vertex(0, 0, 0, 0, 0);    //bas
    cube.vertex(0, c, 0, 0, 1);
    cube.vertex(c, c, 0, 1, 1);
    cube.vertex(c, 0, 0, 1, 0);
    
    cube.fill(0, 255, 0);
    cube.vertex(0, 0, c, 0, 0);    //haut
    cube.vertex(0, c, c, 0, 1);
    cube.vertex(c, c, c, 1, 1);
    cube.vertex(c, 0, c, 1, 0);
    
    cube.fill(0, 0, 255);
    cube.vertex(0, 0, 0, 0, 0);    //droite
    cube.vertex(0, 0, c, 0, 1);
    cube.vertex(0, c, c, 1, 1);
    cube.vertex(0, c, 0, 1, 0);
    
    cube.fill(150, 150, 0);
    cube.vertex(c, 0, 0, 0, 0);    //droite
    cube.vertex(c, 0, c, 0, 1);
    cube.vertex(c, c, c, 1, 1);
    cube.vertex(c, c, 0, 1, 0);
    
    cube.fill(0, 150, 150);
    cube.vertex(0, 0, 0, 0, 0);    // back
    cube.vertex(0, 0, c, 0, 1);
    cube.vertex(c, 0, c, 1, 1);
    cube.vertex(c, 0, 0, 1, 0);
    
    cube.fill(150, 0, 150);
    cube.vertex(0, c, 0, 0, 0);    // back
    cube.vertex(0, c, c, 0, 1);
    cube.vertex(c, c, c, 1, 1);
    cube.vertex(c, c, 0, 1, 0);
  cube.endShape();
  return cube;
} //<>//
