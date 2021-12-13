float camX = 0;
float camY = 0;
float camZ = 0;
float rayon = 500;
float theta = 0;
float phi = 0;
float centerX = 0;
float centerY = 0;
float centerZ = 0;
float X = 0;
float Y = 0;
float Z = 0;

int taille = 50;
int puissanceLum = 200;
PShape chaise;
PShape table;
PShape walls;
PShape scene;
PShape neon;

PVector[] lightPos = {
  new PVector(taille, -taille*4, -taille*4),
  new PVector(taille, -taille*4, 0),
  new PVector(taille, -taille*4, taille*4),
  new PVector(taille, taille*5, -taille*4),
  new PVector(taille, taille*5, 0),
  new PVector(taille, taille*5, taille*4)
};

PVector[] lightColor = {
  new PVector(puissanceLum, puissanceLum, puissanceLum),
  new PVector(puissanceLum, puissanceLum, puissanceLum),
  new PVector(puissanceLum, puissanceLum, puissanceLum),
  new PVector(puissanceLum, puissanceLum, puissanceLum),
  new PVector(puissanceLum, puissanceLum, puissanceLum),
  new PVector(puissanceLum, puissanceLum, puissanceLum)
};

void setup() {
  size(800, 800, P3D);
  scene = createShape(GROUP);
  chaise = new Chaise(taille).dessiner(0, -taille/10, 0);
  table = new Table(taille).dessiner(0, -2*taille/3, taille/2);
  int offset = taille;
  for(int i = 0; i < 4; i++) {
    for(int j = 0; j < 4; j++) {
      chaise = new Chaise(taille).dessiner(taille*2*j + taille/2, -taille/20 + taille*4, taille*i*3 - taille*i/2 + offset);
      scene.addChild(chaise);
      chaise = new Chaise(taille).dessiner(taille*2*j + taille + taille/2 + taille/10, -taille/20 + taille*4, taille*i*3 - taille*i/2 + offset);
      scene.addChild(chaise);
      if(j<3) {
        table = new Table(taille).dessiner(taille*3*j, -2*taille/3 + taille*4 + taille/20, taille*i*3 - taille*i/2+ taille/2 + offset);
        scene.addChild(table);
      }
    }
  }
  for(int i=0; i<lightPos.length; i++) {
     neon = new Neon(taille).setEmissive((int)lightColor[i].x, (int)lightColor[i].y, (int)lightColor[i].z).dessiner((int)lightPos[i].x-taille/10, (int)lightPos[i].y, (int)lightPos[i].z);
     scene.addChild(neon);
  }
  walls = murs();
  scene.addChild(walls);
  scene.rotateY(radians(270));
  scene.rotateZ(radians(180));
  scene.rotateX(radians(-180));
  println("x rouge y vert z bleu");
}

void draw() {
  background(0);
  shader(loadShader("LightShaderTexFrag.glsl", "LightShaderTexVert.glsl"));
  stroke(0);
  ambientLight(10, 10, 10);
  for(int i=0; i<lightPos.length; i++) {
    lightSpecular(lightColor[i].x, lightColor[i].y, lightColor[i].z);
    pointLight(lightColor[i].x, lightColor[i].y, lightColor[i].z, 
               lightPos[i].x - taille*-1, lightPos[i].y*1, lightPos[i].z*-4);
  }
  translate(taille, taille*6, taille*6);
  shape(scene);

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
    if(key == ' ') {
      Z = Z + vitesse;
    } else if(key == 'z') {
      Y = Y + vitesse;
    } else if(key == 's') {
      Y = Y - vitesse;;
    } else if(key == 'q') {
      X = X + vitesse;
    } else if(key == 'd') {
      X = X - vitesse;
    } else if(key == 'c') {
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
    } else if(key == '+') {
      puissanceLum += 50;
    } else if(key == '-') {
      puissanceLum -= 50;
    }
}

PShape murs() {
  PImage solTex = loadImage("ressources/sol.png");
  PImage plafondTex = loadImage("ressources/plafond.png");
  PImage blancTex = loadImage("ressources/blanc.png");
  color beigeCol = color(255, 255, 229);
  color verre = color(200, 200, 200, 50);
  PShape murs = createShape(GROUP);
  
  textureWrap(REPEAT);
  PShape sol = new Rectangle(-taille, 0, -taille*5, -taille*12, taille*15, -taille/10, solTex, color(255, 0, 0), 100).dessiner();
  PShape plafond = new Rectangle(-taille, 0, taille/5, -taille*12, taille*15, -taille/10, plafondTex, color(255, 255, 255), 100).dessiner();
  PShape arriere = new Rectangle(-taille, 0, -taille*5, -taille*12, taille/10, taille*5 + taille/10, blancTex, beigeCol, 100).dessiner();
  PShape devant = new Rectangle(taille*14, 0, -taille*5, -taille*12, taille/10, taille*5 + taille/10, blancTex, beigeCol, 100).dessiner();
    PShape tableau = new Rectangle(taille*14 - taille/10, -taille, -taille*4, -taille*8, taille/10, taille*4, blancTex, color(100, 100, 100), 100).setBas(loadImage("ressources/tableau.png")).dessiner();
  
  PShape gauche = createShape(GROUP);
    PShape gaucheHaut = new Rectangle(taille, -taille*12, -taille, taille/10, taille*11, taille + taille/10, blancTex, beigeCol, 100).dessiner();
    PShape gaucheBas = new Rectangle(taille, -taille*12, -taille*6 + taille, taille/10, taille*11, taille, blancTex, beigeCol, 100).dessiner();
    PShape gaucheDroite = new Rectangle(-taille, -taille*12, -taille*6 + taille, taille/10, taille*2, taille*5 + taille/10, blancTex, beigeCol, 100).dessiner();
    PShape gaucheGauche = new Rectangle(taille*12, -taille*12, -taille*6 + taille, taille/10, taille*2, taille*5 + taille/10, blancTex, beigeCol, 100).dessiner();
    PShape baie = new Rectangle(taille, -taille*12, -taille*4, taille/10, taille*11, taille*3, blancTex, verre, 1000).dessiner();
  gauche.addChild(gaucheHaut);
  gauche.addChild(gaucheBas);
  gauche.addChild(gaucheGauche);
  gauche.addChild(gaucheDroite);
  gauche.addChild(baie);
  
  PShape droite = new Rectangle(-taille, 0, -taille*4 - taille, taille/10, taille*15, taille*5 + taille/10, blancTex, beigeCol, 100).dessiner();
  textureWrap(CLAMP);
  
  murs.addChild(sol);
  murs.addChild(arriere);
  murs.addChild(devant);
  murs.addChild(tableau);
  murs.addChild(plafond);
  murs.addChild(gauche);
  murs.addChild(droite);
  return murs;
}
