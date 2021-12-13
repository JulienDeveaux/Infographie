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
float moveZ = 0;
Boolean move = false;
PShape cube;
PShape tetra;
int taille = 50;

int inc = 6;

void setup() {
  size(400, 400, P3D);
  
  /*PShape tr = triangle(new PVector(0, 0, taille), new PVector(taille, 0, 0), new PVector(0, taille, 0));
  PShape tr2 = triangle(new PVector(0, 0, taille), new PVector(taille, 0, 0), new PVector(taille, taille, taille));      // OLD TETRAETDRE DRAW
  PShape tr3 = triangle(new PVector(taille, taille, taille), new PVector(taille, 0, 0), new PVector(0, taille, 0));
  PShape tr4 = triangle(new PVector(taille, taille, taille), new PVector(0, 0, taille), new PVector(0, taille, 0));
  
  //tetra = tetraedre(tr, tr2, tr3, tr4);*/
  
  
  /*PShape tr = recTriangle(inc, new PVector(0, 0, taille), new PVector(taille, 0, 0), new PVector(0, taille, 0));
  PShape tr2 = recTriangle(inc, new PVector(0, 0, taille), new PVector(taille, 0, 0), new PVector(taille, taille, taille));      // NEW TETRAETDRE DRAW
  PShape tr3 = recTriangle(inc, new PVector(taille, taille, taille), new PVector(taille, 0, 0), new PVector(0, taille, 0));
  PShape tr4 = recTriangle(inc, new PVector(taille, taille, taille), new PVector(0, 0, taille), new PVector(0, taille, 0));*/
  
  PShape tr = recTriangle(inc, new PVector(-taille/2, -taille/2, taille/2), new PVector(taille/2, -taille/2, -taille/2), new PVector(-taille/2, taille/2, -taille/2));
  PShape tr2 = recTriangle(inc, new PVector(-taille/2, -taille/2, taille/2), new PVector(taille/2, -taille/2, -taille/2), new PVector(taille/2, taille/2, taille/2));      // NEW NEW TETRAETDRE DRAW
  PShape tr3 = recTriangle(inc, new PVector(taille/2, taille/2, taille/2), new PVector(taille/2, -taille/2, -taille/2), new PVector(-taille/2, taille/2, -taille/2));
  PShape tr4 = recTriangle(inc, new PVector(taille/2, taille/2, taille/2), new PVector(-taille/2, -taille/2, taille/2), new PVector(-taille/2, taille/2, -taille/2));
  
  tetra = tetraedre(tr, tr2, tr3, tr4);
  cube = creerCube(taille);
}

void draw() {
  background(255);
  stroke(0);
    
  bougerCamera();
    
  camera(
    camX, camY, camZ,   // observateur : position de la camera.
    0, 0, 0,            // sujet : position du sujet visé.
    0, 1, 0);           // orientation : vecteur "haut".
    
  noFill();
  //sphere(taille);
  shape(tetra);
  //shape(cube);
    
  /*noStroke();           // debug positions
  fill(255, 255, 0);      // jaune
  translate(0, 0, 0);
  sphere(15);
  translate(-0, -0, -0);
  
  fill(0, 255, 255);      // bleu
  translate(0, taille, 0);
  sphere(15);
  translate(-0, -taille, -0);
  
  fill(0, 0, 0);          // noir
  translate(0, 0, taille);
  sphere(15);
  translate(-0, -0, -taille);*/
}

PShape recTriangle(int n, PVector a, PVector b, PVector c) {  
  PShape gp = createShape(GROUP);
  if(n > 0) {             //   A
                          //B     C
    gp.addChild(recTriangle(n-1, new PVector((a.x + b.x)/2, (a.y + b.y)/2, (a.z + b.z)/2), new PVector((b.x + c.x)/2, (b.y + c.y)/2, (b.z + c.z)/2), new PVector((c.x + a.x)/2, (c.y + a.y)/2, (c.z + a.z)/2)));
    gp.addChild(recTriangle(n-1, a, new PVector((a.x + c.x)/2, (a.y + c.y)/2, (a.z + c.z)/2), new PVector((b.x + a.x)/2, (b.y + a.y)/2, (b.z + a.z)/2)));
    gp.addChild(recTriangle(n-1, new PVector((b.x + a.x)/2, (b.y + a.y)/2, (b.z + a.z)/2), b, new PVector((b.x + c.x)/2, (b.y + c.y)/2, (b.z + c.z)/2)));
    gp.addChild(recTriangle(n-1, new PVector((b.x + c.x)/2, (b.y + c.y)/2, (b.z + c.z)/2), new PVector((a.x + c.x)/2, (a.y + c.y)/2, (a.z + c.z)/2), c));
  } else {
    return triangle(a, b, c);
  }
  return gp;
}

PShape tetraedre(PShape a, PShape b, PShape c, PShape d) {
  PShape tetra = createShape(GROUP);
  tetra.addChild(a);
  tetra.addChild(b);
  tetra.addChild(c);
  tetra.addChild(d);
  return tetra;
}

PShape triangle(PVector a, PVector b, PVector c) {
  a = a.copy().normalize().mult(taille);
  b = b.copy().normalize().mult(taille);
  c = c.copy().normalize().mult(taille);
  PShape triangle = createShape();
  triangle.beginShape(TRIANGLE_STRIP);
    triangle.fill(255, 0, 0);
    triangle.vertex(a.x, a.y, a.z);
    triangle.vertex(b.x, b.y, b.z);
    triangle.vertex(c.x, c.y, c.z);
  triangle.endShape();
  return triangle;
}

PShape creerCube(int c) {
  PShape cube = createShape();
  cube.beginShape(QUADS);
    cube.noFill();
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

void bougerCamera() {
  // Calcul de la position cartésienne sur le
  // plan XZ :
  camX = rayon * cos(phi) * sin(theta);
  camY = rayon * sin(phi);
  camZ = rayon * cos(phi) * cos(theta);
  camZ += moveZ;


  // On incrémente l'angle :
  //theta = (theta + 0.05) % TWO_PI;
  if(move) {
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
}

void mousePressed() {
  move = !move;
}

void mouseWheel(MouseEvent event) {
  if(event.getCount() > 0) {
    moveZ -= 50;
  } else {
    moveZ += 50;
  }
}
