// Distance de la camera au sujet.
float rayon = 200;
float angle = 0;

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

int inc = 5;

PShader lightShader;
int lightpos = 300;


PVector[] lightColor = {
  new PVector(255, 255, 255),
  new PVector(40, 100, 255),
  new PVector(255, 200, 55),
  new PVector(255, 0, 0)
};

void setup() {
  size(400, 400, P3D);
  
  PShape tr = recTriangle(inc, new PVector(-taille/2, -taille/2, taille/2), new PVector(taille/2, -taille/2, -taille/2), new PVector(-taille/2, taille/2, -taille/2));
  PShape tr2 = recTriangle(inc, new PVector(-taille/2, -taille/2, taille/2), new PVector(taille/2, -taille/2, -taille/2), new PVector(taille/2, taille/2, taille/2));      // NEW NEW TETRAETDRE DRAW
  PShape tr3 = recTriangle(inc, new PVector(taille/2, taille/2, taille/2), new PVector(taille/2, -taille/2, -taille/2), new PVector(-taille/2, taille/2, -taille/2));
  PShape tr4 = recTriangle(inc, new PVector(taille/2, taille/2, taille/2), new PVector(-taille/2, -taille/2, taille/2), new PVector(-taille/2, taille/2, -taille/2));
  
  tetra = tetraedre(tr, tr2, tr3, tr4);
  
  lightShader = loadShader("LambertDiffuseFrag.glsl", "LambertDiffuseVert.glsl");
}

void draw() {
  background(0);
  shader(lightShader);

PVector[] lightPos = { 
  new PVector(300, -300, 300),
  new PVector(-300, 300, 300),
  new PVector(-300, lightpos, -300),
  new PVector(0, -300, 0)
};

  if(lightpos > 1000) {
    lightpos = -1000;
  } else {
    lightpos += 10;
  }
  
  ambientLight(10, 10, 10);
  
  for(int i=0; i<lightPos.length; i++) {
    lightSpecular(lightColor[i].x, lightColor[i].y, lightColor[i].z);
    pointLight(lightColor[i].x, lightColor[i].y, lightColor[i].z, 
               lightPos[i].x, lightPos[i].y, lightPos[i].z);
  }  
  

  stroke(0);
    
  bougerCamera();
    
  camera(
    camX, camY, camZ,   // observateur : position de la camera.
    0, 0, 0,            // sujet : position du sujet visé.
    0, 1, 0);           // orientation : vecteur "haut".
    
  
  for(int i=0; i<lightPos.length; i++) {
    pushMatrix();
        noStroke();
        fill(0, 0, 0);
        emissive(lightColor[i].x, lightColor[i].y, lightColor[i].z);
        translate(lightPos[i].x, lightPos[i].y, lightPos[i].z);
        box(10, 10, 10);
    popMatrix();
  }
  emissive(0, 0, 0);
  noFill();
  shape(tetra);


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
  PVector an = a.copy().normalize();
  PVector bn = b.copy().normalize();
  PVector cn = c.copy().normalize();
  PShape triangle = createShape();
  triangle.beginShape(TRIANGLE_STRIP);
    triangle.noStroke();
    triangle.shininess(500);      // Reflective plus c'est haut
    triangle.fill(255, 255, 255);
    
    triangle.normal(an.x, an.y, an.z);
    triangle.vertex(a.x, a.y, a.z, 1, 0);
    
    triangle.normal(bn.x, bn.y, bn.z);
    triangle.vertex(b.x, b.y, b.z, 0, 1);
    
    triangle.normal(cn.x, cn.y, cn.z);
    triangle.vertex(c.x, c.y, c.z, 1, 1);
    
  triangle.endShape();
  return triangle;
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
