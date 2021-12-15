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
PShape scene;

PVector[] lightPos = {
  new PVector(taille*-2, 0, -taille*5),
  new PVector(taille*-2, 0, -taille),
  new PVector(taille*-2, 0, - taille*10),
  new PVector(taille*-10, 0, -taille*5),
  new PVector(taille*-10, 0, -taille),
  new PVector(taille*-10, 0, -taille*10),
  new PVector(-taille*4, 0, -taille*13)
};

int puissanceLum = 150;
PVector[] lightColor = {
  new PVector(puissanceLum, puissanceLum, puissanceLum),
  new PVector(puissanceLum, puissanceLum, puissanceLum),
  new PVector(puissanceLum, puissanceLum, puissanceLum),
  new PVector(puissanceLum, puissanceLum, puissanceLum),
  new PVector(puissanceLum, puissanceLum, puissanceLum),
  new PVector(puissanceLum, puissanceLum, puissanceLum),
  new PVector(puissanceLum, puissanceLum, puissanceLum)
};

PShape table, chaise;

void setup() {
  frameRate(10);
  size(800, 800, P3D);  
  shader(loadShader("LightShaderTexFrag.glsl", "LightShaderTexVert.glsl"));
  scene = createShape(GROUP);
  PShape chaise = new Chaise(taille).dessiner(0, -taille/10, 0);
  PShape table = new Table(taille).dessiner(0, -2*taille/3, taille/2);
  int offset = taille;
  for(int i = 0; i < 4; i++) {
    for(int j = 0; j < 3; j++) {
      chaise = new Chaise(taille).dessiner(taille*3*j + taille*j/20 + 2*taille/4 + taille, -taille/20 + taille*4/*taille*4*/, taille*i*3 - taille*i/2 + offset);
      scene.addChild(chaise);
      chaise = new Chaise(taille).dessiner(taille*3*j + taille*j/20 + 2*taille/5, -taille/20 + taille*4, taille*i*3 - taille*i/2 + offset);
      scene.addChild(chaise);
      table = new Table(taille).dessiner(taille*3*j, -2*taille/3 + taille*4 + taille/20, taille*i*3 - taille*i/2+ taille/2 + offset);
      scene.addChild(table);
    }
  }
  
  PShape neon;
  for(int i=0; i<lightPos.length-1; i++) {    //-1 pour le néon du tableau
     neon = new Neon(taille).setEmissive((int)lightColor[i].x, (int)lightColor[i].y, (int)lightColor[i].z).dessiner((int)lightPos[i].y-taille/10, (int)lightPos[i].z, (int)lightPos[i].x);
     scene.addChild(neon);
  }
  
  PShape tableProf = createShape(GROUP);
    PShape tProf = new Table(taille).dessinerOrdis(false).dessiner(taille*3 + taille/2, -2*taille/3 + taille*4 + taille/20, taille*9 + taille/2 + offset);
    PShape cProf = new Chaise(taille).invert(true).dessiner(taille*4, -taille/20 + taille*4 + taille/20, taille*11 - taille/3);
  tableProf.addChild(tProf);
  tableProf.addChild(cProf);
  
  PShape neonTableau = new Neon(taille).isGrand(true).setEmissive((int)lightColor[6].x, (int)lightColor[6].y, (int)lightColor[6].z).dessiner((int)lightPos[6].y-taille/10, (int)lightPos[6].z, (int)lightPos[6].x);
  
  scene.addChild(neonTableau);
  scene.addChild(tableProf);
  scene.addChild(ecranTactile());
  scene.addChild(murs());
  scene.rotateY(radians(270));
  scene.rotateZ(radians(270));
  scene.rotateX(radians(-180));
  println("x rouge y vert z bleu\nCommandes : z-s-q-d-c-espace");
}

void draw() {
  background(146,184,197);
  stroke(0);
  ambientLight(10, 10, 10);
  for(int i=0; i<lightPos.length; i++) {
    lightSpecular(lightColor[i].x, lightColor[i].y, lightColor[i].z);
    pointLight(lightColor[i].x, lightColor[i].y, lightColor[i].z, 
               lightPos[i].x - taille, lightPos[i].y, lightPos[i].z);
  }
  translate(taille*6, taille*-3, taille*7);
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

PShape ecranTactile() {
  int reflective = 50;
  int mat = 10000;
  PImage noir = loadImage("ressources/noir.png");
  color c = color(255, 255, 255);
  PShape ecranFinal = createShape(GROUP);
  
  PShape ecran = new Rectangle(-taille/10, -taille*4, -taille - taille/2, taille*2, taille/3, taille*4, noir, c, mat).setGauche(loadImage("ressources/ecran.png")).dessiner();
  PShape pied = createShape(GROUP);
    PShape barre = new Rectangle(-taille/20, 0, 0, taille/10, taille/8, taille, noir, c, reflective).dessiner();
    PShape bRoulettes1 = new Rectangle(-taille/2, 0, -taille/5, taille/5, taille, taille/5, noir, c, reflective).dessiner(); 
    PShape bRoulettes2 = new Rectangle(-taille/2, 0, taille, taille/5, taille, taille/5, noir, c, reflective).dessiner(); 
    PShape barreCentrale =  new Rectangle(-taille/10, -taille*2, taille/3, taille*2, taille/4, taille/3, noir, c, reflective).dessiner(); 
  pied.addChild(barre);
  pied.addChild(bRoulettes1);
  pied.addChild(bRoulettes2);
  pied.addChild(barreCentrale);
  
  ecranFinal.addChild(pied);
  ecranFinal.addChild(ecran);
  ecranFinal.translate(-taille*16, taille*5 - taille/5, -taille*2);
  ecranFinal.rotateY(radians(225));
  ecranFinal.rotateX(radians(-90));
  return ecranFinal;
}

PShape murs() {
  PImage solTex = loadImage("ressources/sol.png");
  PImage plafondTex = loadImage("ressources/plafond.png");
  PImage blancTex = loadImage("ressources/blanc.png");
  color beigeCol = color(245, 220, 200);
  color verre = color(200, 200, 200, 50);
  PShape murs = createShape(GROUP);
  
  textureWrap(REPEAT);
  PShape sol = new Rectangle(-taille, 0, -taille*5, -taille*12, taille*15, -taille/10, solTex, color(150, 0, 0), 100).dessiner();
  PShape plafond = new Rectangle(-taille, 0, taille/5, -taille*12, taille*15, -taille/10, plafondTex, color(255, 255, 255), 100).dessiner();
  PShape arriere = new Rectangle(-taille, 0, -taille*5, -taille*12, taille/10, taille*5 + taille/10, blancTex, beigeCol, 100).dessiner();
  PShape devant = createShape(GROUP);
    PShape devantMur = new Rectangle(taille*14, 0, -taille*5, -taille*12, taille/10, taille*5 + taille/10, blancTex, beigeCol, 100).dessiner();
    PShape tableau = new Rectangle(taille*14 - taille/10, -taille, -taille*4, -taille*8, taille/10, taille*4, blancTex, color(100, 100, 100), 100).setBas(loadImage("ressources/tableau.png")).dessiner();
  devant.addChild(devantMur);
  devant.addChild(tableau);
  
  PShape droite = createShape(GROUP);
    PShape droiteDroite = new Rectangle(-taille, 0, -taille*4 - taille, taille/10, taille*12 + taille/2, taille*5 + taille/10, blancTex, beigeCol, 100).dessiner();
    PShape droiteGauche = new Rectangle(-taille*-13 + taille/2, 0, -taille*4 - taille, taille/10, taille/2, taille*5 + taille/10, blancTex, beigeCol, 100).dessiner();
    PShape droiteHaut = new Rectangle(-taille*-11 + taille/2, 0, -taille + taille/10, taille/10, taille*2, taille*1, blancTex, beigeCol, 100).dessiner();
    PShape porte = new Rectangle(taille*12 - taille/2, 0, -taille*4 - taille, taille/10, taille*2, taille*4 + taille/10, loadImage("ressources/bleu.png"), beigeCol, 100).dessiner();
  droite.addChild(porte);
  droite.addChild(droiteDroite);
  droite.addChild(droiteGauche);
  droite.addChild(droiteHaut);

  PShape gauche = createShape(GROUP);
    PShape gaucheHaut = new Rectangle(taille, -taille*12, -taille/2 + taille/4 + taille/20, taille/10, taille*11, taille/3, blancTex, beigeCol, 100).dessiner();
    PShape gaucheBas = new Rectangle(taille, -taille*12, -taille*6 + taille, taille/10, taille*11, taille*2 - taille/5 + taille/30, blancTex, beigeCol, 100).dessiner();
    PShape gaucheDroite = new Rectangle(-taille, -taille*12, -taille*6 + taille, taille/10, taille*2, taille*5 + taille/10, blancTex, beigeCol, 100).dessiner();
    PShape gaucheGauche = new Rectangle(taille*12, -taille*12, -taille*6 + taille, taille/10, taille*2, taille*5 + taille/10, blancTex, beigeCol, 100).dessiner();
    PShape baie = new Rectangle(taille, -taille*12, -taille*3 - taille/5 + taille/30, taille/10, taille*11, taille*3 - taille/20, blancTex, verre, 1000).dessiner();
    PShape chauffage = new Rectangle(taille*4, -taille*12 + taille/10, -taille*4 - taille/2 + taille/30, taille/5, taille*5, taille, loadImage("ressources/radiateur.png"), color(240, 240, 240), 1000).dessiner();
  gauche.addChild(gaucheHaut);
  gauche.addChild(gaucheBas);
  gauche.addChild(gaucheGauche);
  gauche.addChild(gaucheDroite);
  gauche.addChild(chauffage);
  gauche.addChild(baie);
  
  textureWrap(CLAMP);
  
  murs.addChild(sol);
  /*murs.addChild(arriere);
  murs.addChild(devant);
  murs.addChild(plafond);
  murs.addChild(droite);
  murs.addChild(gauche);*/
  return murs;
}
