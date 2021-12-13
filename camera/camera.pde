// Distance de la camera au sujet.
float rayon = 200;

// Angle de la camera avec le sujet sur le plan XZ.
float theta = 0;
float phi = 0;

// Position cartésienne de la camera
// calculée à partir du rayon et de l'angle.
float camX = 0;
float camY = 0;
float camZ = 0;

void setup() {
  size(400, 400, P3D);
}

void draw() {
  background(255);
  noFill();
  stroke(0);
    
  bougerCamera();
    
  camera(
    camX, camY, camZ,   // observateur : position de la camera.
    0, 0, 0,            // sujet : position du sujet visé.
    0, 1, 0);           // orientation : vecteur "haut".
  
  box(100);
}

void bougerCamera() {
  // Calcul de la position cartésienne sur le
  // plan XZ :
  camX = rayon * cos(phi) * sin(theta);
  camY = rayon * sin(phi);
  camZ = rayon * cos(phi) * cos(theta);


  // On incrémente l'angle :
  //theta = (theta + 0.05) % TWO_PI;
  if(mouseX < width/3 + 100 && mouseX > width / 3) {
    
  } else if(mouseX > height / 2) {
    theta = (theta + 0.03) % TWO_PI;
  } else {
    theta = (theta - 0.03) % TWO_PI;
  }
  if(mouseY < width/3 + 100 && mouseY > width / 3) {
    
  } else if(mouseY > height / 2) {
    phi = (phi + 0.03) % TWO_PI;
  } else {
    phi = (phi - 0.03) % TWO_PI;
  }
}
