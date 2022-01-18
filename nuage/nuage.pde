float camX = 0;
float camY = 0;
float camZ = 0;
float rayon = 450;
float theta = -270;
float phi = -10;
float centerX = 0;
float centerY = 0;
float centerZ = 0;
float X = 0;
float Y = 0;
float Z = 0;

int taille = 50;

void setup() {
  size(800, 800, P3D);
}

void draw() {
  background(146, 184, 197);
  PShape nuage = new Nuage(50).dessiner(0, 0, 0);
  shape(nuage);
  

  updateCamera();
  camera(
    camX, camY, camZ,                     // observateur : position de la camera.
    centerX, centerY, centerZ,            // sujet : position du sujet visé.
    0, 1, 0);                             // orientation : vecteur "haut".
  Axis axis = new Axis(0.0, 0.0, 0.0, width, height, width, 2);
  axis.draw(color(255, 0, 0), color(0, 255, 0), color(0, 0, 255));
}

void updateCamera() {
  camX = rayon * cos(radians(phi)) * cos(radians(theta)) + X;
  camY = rayon * sin(radians(phi)) + Y;
  camZ = rayon * cos(radians(phi)) * sin(radians(theta)) + Z;
}

void mouseDragged() {
  phi = map(mouseY, 0, height, 180, -180);
  theta = map(mouseX, 0, width, -180, 180);
}

void mouseWheel(MouseEvent event) {
  if(event.getCount() > 0) {
    rayon += 50;
  } else {
    rayon -= 50;
  }
}

void keyPressed() {
  int vitesse = 30;
    if(key == 's') {
      Z = Z + vitesse;
      centerZ += vitesse;
    } else if(key == 'c') {
      Y = Y + vitesse;
      centerY+=vitesse;
    } else if(key == ' ') {
      Y = Y - vitesse;
      centerY-=vitesse;
    } else if(key == 'd') {
      centerX += vitesse;
      X = X + vitesse;
    } else if(key == 'q') {
      centerX -= vitesse;
      X = X - vitesse;
    } else if(key == 'z') {
      centerZ -= vitesse;
      Z = Z - vitesse;
    } else if(keyCode == RIGHT) {
      centerX += vitesse;
    } else if(keyCode == LEFT) {
      centerX -= vitesse;
    } else if(keyCode == DOWN) {
      centerY += vitesse;
    } else if(keyCode == UP) {
      centerY -= vitesse;
    } else if(key == '8') {
      taille += 50;
    } else if(key == '2') {
      taille -=50;
    }
}
