// Position cartésienne de la camera
// calculée à partir du rayon et de l'angle.
float camX = 0;
float camY = 0;
float camZ = 120;
float centerX = 0;
float centerY = 0;
float centerZ = 0;
Boolean move = true;

void setup() {
  size(400, 400, P3D);
}

void draw() {
  background(255);
  shader(loadShader("LightShaderTexFrag.glsl", "LightShaderTexVert.glsl"));
  stroke(0);
  textureMode(NORMAL);
  PShape cube = creerCube(50);
  cube.translate(-25, -25, -25);
  shape(cube);

  println(camX + " " + camY + " " + camZ);
    
  camera(
    camX, camY, camZ,                     // observateur : position de la camera.
    centerX, centerY, centerZ,            // sujet : position du sujet visé.
    0, 1, 0);                             // orientation : vecteur "haut".

}

void keyPressed() {
  int vitesse = 30;
  if(move) {
    if(key == ' ') {
      camZ = camZ + vitesse;
    } else if(key == 'z') {
      camY = camY + vitesse;
    } else if(key == 's') {
      camY = camY - vitesse;;
    } else if(key == 'q') {
      camX = camX + vitesse;
    } else if(key == 'd') {
      camX = camX - vitesse;
    } else if(key == 'c') {
      camZ = camZ - vitesse;
    } else if(keyCode == RIGHT) {
      centerX += vitesse;
    } else if(keyCode == LEFT) {
      centerX -= vitesse;
    } else if(keyCode == DOWN) {
      centerY += vitesse;
    } else if(keyCode == UP) {
      centerY -= vitesse;
    }
  }
}

void mousePressed() {
  move = !move;
}

PShape creerCube(int c) {
  PImage tex = loadImage("ewok.png");
  PImage bois = loadImage("bois.jpg");
  PShape cubeFinal = createShape(GROUP);
  
  PShape cube = createShape();
  cube.beginShape(QUADS);
    cube.texture(tex);
    cube.vertex(0, 0, 0, 0, 0);    //bas
    cube.vertex(0, c, 0, 0, 1);
    cube.vertex(c, c, 0, 1, 1);
    cube.vertex(c, 0, 0, 1, 0);
  cube.endShape();
  
  PShape cube2 = createShape();
    cube2.beginShape(QUADS);
    cube2.texture(tex);
    cube2.vertex(0, 0, c, 0, 0);    //haut
    cube2.vertex(0, c, c, 0, 1);
    cube2.vertex(c, c, c, 1, 1);
    cube2.vertex(c, 0, c, 1, 0);
  cube2.endShape();
  
  PShape cube3 = createShape();
    cube3.beginShape(QUADS);
    cube3.texture(bois);
    cube3.vertex(0, 0, 0, 0, 0);    //droite
    cube3.vertex(0, 0, c, 0, 1);
    cube3.vertex(0, c, c, 1, 1);
    cube3.vertex(0, c, 0, 1, 0);
  cube3.endShape();
  
  PShape cube4 = createShape();
    cube4.beginShape(QUADS);
    cube4.texture(bois);
    cube4.vertex(c, 0, 0, 0, 0);    //droite
    cube4.vertex(c, 0, c, 0, 1);
    cube4.vertex(c, c, c, 1, 1);
    cube4.vertex(c, c, 0, 1, 0);
  cube4.endShape();
    
  PShape cube5 = createShape();
    cube5.beginShape(QUADS);
    cube5.texture(tex);
    cube5.vertex(0, 0, 0, 0, 0);    // back
    cube5.vertex(0, 0, c, 0, 1);
    cube5.vertex(c, 0, c, 1, 1);
    cube5.vertex(c, 0, 0, 1, 0);
  cube5.endShape();
    
  PShape cube6 = createShape();
    cube6.beginShape(QUADS);
    cube6.texture(tex);
    cube6.vertex(0, c, 0, 0, 0);    // back
    cube6.vertex(0, c, c, 0, 1);
    cube6.vertex(c, c, c, 1, 1);
    cube6.vertex(c, c, 0, 1, 0);
  cube6.endShape();
  
  cubeFinal.addChild(cube);
  cubeFinal.addChild(cube2);
  cubeFinal.addChild(cube3);
  cubeFinal.addChild(cube4);
  cubeFinal.addChild(cube5);
  cubeFinal.addChild(cube6);
  return cubeFinal;
}
