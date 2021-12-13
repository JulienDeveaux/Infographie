float camX = 0;
float camY = 0;
float camZ = 0;
float rayon = 800;
float theta = -177.75;
float phi = -2.69;
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
  new PVector(taille*-2, 0 - taille*10, -taille*9),      // - taille*10 pour mieux voir
  new PVector(taille*-10, 0, -taille*5),
  new PVector(taille*-10, 0, -taille),
  new PVector(taille*-10, 0, -taille*9)
};

int puissanceLum = 200;
PVector[] lightColor = {
  new PVector(puissanceLum, puissanceLum, puissanceLum),
  new PVector(puissanceLum, puissanceLum, puissanceLum),
  new PVector(puissanceLum, puissanceLum, puissanceLum),
  new PVector(puissanceLum, puissanceLum, puissanceLum),
  new PVector(puissanceLum, puissanceLum, puissanceLum),
  new PVector(puissanceLum, puissanceLum, puissanceLum)
};

void setup() {
  frameRate(3);
  size(800, 800, P3D);
  scene = createShape(GROUP);
  PShape chaise = new Chaise(taille).dessiner(0, -taille/10, 0);
  PShape table = new Table(taille).dessiner(0, -2*taille/3, taille/2);
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
  
  PShape neon;
  for(int i=0; i<lightPos.length; i++) {
     neon = new Neon(taille).setEmissive((int)lightColor[i].x, (int)lightColor[i].y, (int)lightColor[i].z).dessiner((int)lightPos[0].y-taille/10, (int)lightPos[i].z, (int)lightPos[i].x);      //[0].y pour bien placer le néon avec l'offset lumière
     scene.addChild(neon);
  }
  scene.addChild(ecranTactile());
  scene.addChild(murs());
  scene.rotateY(radians(270));
  scene.rotateZ(radians(270));
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
               lightPos[i].x - taille*1, lightPos[i].y*1, lightPos[i].z*1);
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
    if(key == ' ') {
      Z = Z + vitesse;
    } else if(key == 'z') {
      Y = Y + vitesse;
    } else if(key == 's') {
      Y = Y - vitesse;;
    } else if(key == 'd') {
      X = X + vitesse;
    } else if(key == 'q') {
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
    }
}

PShape ecranTactile() {
  int reflective = 50;
  int mat = 10000;
  PImage blanc = loadImage("ressources/blanc.png");
  color c = color(255, 255, 255);
  PShape ecranFinal = createShape(GROUP);
  
  PShape ecran = new Rectangle(-taille/10, -taille*4, -taille - taille/2, taille*2, taille/3, taille*4, blanc, c, mat).setGauche(loadImage("ressources/ecran.png")).dessiner();
  PShape pied = createShape(GROUP);
    PShape barre = new Rectangle(-taille/20, 0, 0, taille/10, taille/8, taille, blanc, c, reflective).dessiner();
    PShape bRoulettes1 = new Rectangle(-taille/2, 0, -taille/5, taille/5, taille, taille/5, blanc, c, reflective).dessiner(); 
    PShape bRoulettes2 = new Rectangle(-taille/2, 0, taille, taille/5, taille, taille/5, blanc, c, reflective).dessiner(); 
    PShape barreCentrale =  new Rectangle(-taille/10, -taille*2, taille/3, taille*2, taille/4, taille/3, blanc, c, reflective).dessiner(); 
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
  PShape devant = new Rectangle(taille*14, 0, -taille*5, -taille*12, taille/10, taille*5 + taille/10, blancTex, beigeCol, 100).dessiner();
    PShape tableau = new Rectangle(taille*14 - taille/10, -taille, -taille*4, -taille*8, taille/10, taille*4, blancTex, color(100, 100, 100), 100).setBas(loadImage("ressources/tableau.png")).dessiner();
  
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
  
  textureWrap(CLAMP);
  
  murs.addChild(sol);
  murs.addChild(arriere);
  murs.addChild(devant);
  murs.addChild(tableau);
  //murs.addChild(plafond);
  //murs.addChild(droite);
  murs.addChild(gauche);
  return murs;
}
