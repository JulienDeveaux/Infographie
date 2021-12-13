float angle = 0f;

void setup() {
  size(600, 600, P3D);
}

void draw() {
  background(0);
  /*pushMatrix();
    translate(width/2, height/2, 0);
    rotateY(angle);
    rotateX(30);
    box(100);
  popMatrix();*/
  PShape cube = creerCube(50);
  translate(width/2,height/2,0);
  cube.translate(-25, -25, -25);
  cube.rotateX(20);
  cube.rotateY(angle);
  shape(cube);
  
  angle += 0.04;
}

PShape creerCube(int c) {
  PShape cube = createShape();
  cube.beginShape(QUADS);
    cube.vertex(0, 0, 0);    //bas
    cube.vertex(0, c, 0);
    cube.vertex(c, c, 0);
    cube.vertex(c, 0, 0);
    
    cube.vertex(0, 0, c);    //haut
    cube.vertex(0, c, c);
    cube.vertex(c, c, c);
    cube.vertex(c, 0, c);
    
    cube.vertex(0, 0, 0);    //droite
    cube.vertex(0, 0, c);
    cube.vertex(0, c, c);
    cube.vertex(0, c, 0);
    
    cube.vertex(c, 0, 0);    //droite
    cube.vertex(c, 0, c);
    cube.vertex(c, c, c);
    cube.vertex(c, c, 0);
    
    cube.vertex(0, 0, 0);    // back
    cube.vertex(0, 0, c);
    cube.vertex(c, 0, c);
    cube.vertex(c, 0, 0);
    
    cube.vertex(0, c, 0);    // back
    cube.vertex(0, c, c);
    cube.vertex(c, c, c);
    cube.vertex(c, c, 0);
  cube.endShape();
  return cube;
}
