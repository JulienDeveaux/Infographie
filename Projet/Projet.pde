float camX = 0;
float camY = 0;
float camZ = 0;
/*camera*/
float rayon = 450;
float theta = -270;
float phi = -10;
float centerX = 15;
float centerY = -50;
float centerZ = 45;
float moveX = 0;
float moveY = 0;
float moveZ = 0;
float xComp = 0;
float zComp = 0;
float angle = 0;
boolean move = false;

/*scene*/
int taille = 50;
PShape scene;

/*mouvement*/
char camGoTo = 'i';

/*position lumière*/
PVector[] lightPos = {
  new PVector(taille*-2, 0, -taille*5),
  new PVector(taille*-2, 0, -taille),
  new PVector(taille*-2, 0, - taille*10),
  new PVector(taille*-10, 0, -taille*5),
  new PVector(taille*-10, 0, -taille),
  new PVector(taille*-10, 0, -taille*10),
  new PVector(-taille*4, 0, -taille*13)
};

/*couleur lumière*/
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

void setup() {
  size(800, 800, P3D);
  shader(loadShader("LightShaderTexFrag.glsl", "LightShaderTexVert.glsl"));
  
  scene = new PShape();
  scene = createShape(GROUP);
  
  /*chaises et tables en rangées*/
  PShape chaise = new Chaise(taille).dessiner(0, -taille/10, 0);
  PShape table = new Table(taille).dessiner(0, -2*taille/3, taille/2);
  int offset = taille;
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 3; j++) {
      chaise = new Chaise(taille).dessiner(taille*3*j + taille*j/20 + 2*taille/4 + taille, -taille/20 + taille*4/*taille*4*/, taille*i*3 - taille*i/2 + offset);
      scene.addChild(chaise);
      chaise = new Chaise(taille).dessiner(taille*3*j + taille*j/20 + 2*taille/5, -taille/20 + taille*4, taille*i*3 - taille*i/2 + offset);
      scene.addChild(chaise);
      table = new Table(taille).dessiner(taille*3*j, -2*taille/3 + taille*4 + taille/20, taille*i*3 - taille*i/2+ taille/2 + offset);
      scene.addChild(table);
    }
  }
  
  /*néons rangés au plafond*/
  PShape neon;
  for (int i=0; i<lightPos.length-1; i++) {    //-1 pour le néon du tableau
    neon = new Neon(taille).setEmissive((int)lightColor[i].x, (int)lightColor[i].y, (int)lightColor[i].z).dessiner((int)lightPos[i].y-taille/10, (int)lightPos[i].z, (int)lightPos[i].x);
    scene.addChild(neon);
  }

  /*table du prof custom*/
  PShape tableProf = createShape(GROUP);
  PShape tProf = new Table(taille).dessinerOrdis(false).dessiner(taille*3 + taille/2, -2*taille/3 + taille*4 + taille/20, taille*9 + taille/2 + offset);
  PShape cProf = new Chaise(taille).invert(true).dessiner(taille*4, -taille/20 + taille*4 + taille/20, taille*11 - taille/3);
  tableProf.addChild(tProf);
  tableProf.addChild(cProf);

  /*néon custom*/
  PShape neonTableau = new Neon(taille).isGrand(true).setEmissive((int)lightColor[6].x, (int)lightColor[6].y, (int)lightColor[6].z).dessiner((int)lightPos[6].y-taille/10, (int)lightPos[6].z, (int)lightPos[6].x);

  /*tables customs*/
  PShape tableFond = createShape(GROUP);
  PShape tableF1 = new Table(taille).dessinerOrdis(false).dessiner(taille + taille/2, -2*taille/3 + taille*4 + taille/20, -taille*2 + taille/10 + offset);
  PShape tableF2 = new Table(taille).dessinerOrdis(false).dessiner(taille*5 + taille/2, -2*taille/3 + taille*4 + taille/20, -taille*2 + taille/10 + offset);
  tableFond.addChild(tableF1);
  tableFond.addChild(tableF2);

  /*construction groupe scene*/
  scene.addChild(tableFond);
  scene.addChild(neonTableau);
  scene.addChild(tableProf);
  scene.addChild(ecranTactile());
  scene.addChild(murs());
  
  println("x rouge y vert z bleu\nCommandes : z-s-q-d-c-espace");
}

void draw() {
  PVector[] lightPos = {      // nouveau lightPos pour pouvoir les bouger en même temps que taille change
    new PVector(taille*-2, 0, -taille*5),
    new PVector(taille*-2, 0, -taille),
    new PVector(taille*-2, 0, - taille*10),
    new PVector(taille*-10, 0, -taille*5),
    new PVector(taille*-10, 0, -taille),
    new PVector(taille*-10, 0, -taille*10),
    new PVector(-taille*4, 0, -taille*13)
  };

  background(146, 184, 197);
  stroke(0);
  ambientLight(10, 10, 10);
  for (int i=0; i<lightPos.length; i++) {
    lightSpecular(lightColor[i].x, lightColor[i].y, lightColor[i].z);
    pointLight(lightColor[i].x, lightColor[i].y, lightColor[i].z,
      lightPos[i].x - taille, lightPos[i].y, lightPos[i].z);
  }
  translate(taille*6, taille*-3, taille*7);
  shape(scene);

  if (camGoTo!='i') {
    if(camGoTo == 'z') {
      moveZ -= 10;
      centerZ -= 10;
    } else if(camGoTo == 's') {
      moveZ += 10;
      centerZ += 10;
    } else if(camGoTo == 'q') {
      moveX -= 10;
      centerX -= 10;
    } else if(camGoTo == 'd') {
      moveX += 10;
      centerX += 10;
    } else if(camGoTo == ' ') {
      moveY -= 10;
      centerY -= 10;
    } else if(camGoTo == 'c') {
      moveY += 10;
      centerY += 10;
    }
  }

  updateCamera();
  camera(
    camX, camY, camZ,                     // observateur : position de la camera.
    centerX, centerY, centerZ,            // sujet : position du sujet visé.
    0, 1, 0);                             // orientation : vecteur "haut".
}

void updateCamera() {
  int sensibility = 15;
  int diffX = mouseX - width/2;
  int diffY = mouseY - width/2;

  if (move) {
    if (abs(diffX) > 100) {    // si la position de x est hors de la "boite" ou on ne bouge pas au centre de l'écran de taille 100*100
      /*xComp et zComp sont la différence entre la position du sujet et de l'oeil*/
      xComp = centerX - camX;
      zComp = centerZ - camZ;
      /*get de l'angle correct de la caméra et on l'oriente vers la souris*/
      angle = correctAngle(xComp, zComp);
      angle+= diffX/(sensibility*10);

      float newXComp = rayon * sin(radians(angle));  // rayon la distance du sujet
      float newZComp = rayon * cos(radians(angle));

      centerX = newXComp + camX;
      centerZ = -newZComp + camZ;
    }

    if (abs(diffY) > 100)
      centerY += diffY/(sensibility/1.5);
  }
  //println(camX + " " + camY + " " + camZ + " " + centerX + " " + centerY + " " + centerZ);
  camX = rayon * cos(radians(phi)) * cos(radians(theta)) + moveX;
  camY = rayon * sin(radians(phi)) + moveY;
  camZ = rayon * cos(radians(phi)) * sin(radians(theta)) + moveZ;
}

public float correctAngle(float xc, float zc) {
  float newAngle = -degrees(atan(xc/zc));
  if (xComp > 0 && zComp > 0)
    newAngle = (90 + newAngle)+90;
  else if (xComp < 0 && zComp > 0)
    newAngle = newAngle + 180;
  else if (xComp < 0 && zComp < 0)
    newAngle = (90+ newAngle) + 270;
  return newAngle;
}

void mousePressed() {
  move = !move;
}

void keyPressed() {
  camGoTo = key;
}

void keyReleased() {
  camGoTo = 'i';
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
  ecranFinal.rotateX(radians(0));
  ecranFinal.rotateY(radians(315));
  ecranFinal.rotateZ(radians(0));
  return ecranFinal;
}

PShape murs() {
  PImage solTex = loadImage("ressources/sol.png");
  PImage plafondTex = loadImage("ressources/plafond.png");
  PImage blancTex = loadImage("ressources/blanc.png");
  PImage porteTex = loadImage("ressources/bleu.png");
  color beigeCol = color(245, 220, 200);
  color noirCol = color(20, 20, 20);
  color verre = color(200, 200, 200, 50);
  PShape murs = createShape(GROUP);

  textureWrap(REPEAT);
  PShape sol = new Rectangle(-taille, 0, -taille*5, -taille*12, taille*15, -taille/10, solTex, color(150, 0, 0), 100).dessiner();
  PShape plafond = new Rectangle(-taille, 0, taille/5, -taille*12, taille*15, -taille/10, plafondTex, color(255, 255, 255), 100).dessiner();
  
  
  PShape devant = createShape(GROUP);
  PShape devantDroite = new Rectangle(taille*14, 0, -taille*5, -taille*9, taille/10, taille*5 + taille/10, blancTex, beigeCol, 100).dessiner();
  PShape devantGauche = new Rectangle(taille*14, -taille*11, -taille*5, -taille*1, taille/10, taille*5 + taille/10, blancTex, beigeCol, 100).dessiner();
  PShape devantHaut = new Rectangle(taille*14, -taille*9, -taille + taille/10, -taille*2, taille/10, taille, blancTex, beigeCol, 100).dessiner();
  PShape devantPorte = new Rectangle(taille*14, -taille*11, -taille*5, taille*2, taille/10, taille*4 + taille / 10, porteTex, beigeCol, 100).dessiner();
  PShape tableau = new Rectangle(taille*14 - taille/10, -taille, -taille*4, -taille*8, taille/10, taille*4, blancTex, color(100, 100, 100), 100).setBas(loadImage("ressources/tableau.png")).dessiner();
  devant.addChild(devantDroite);
  devant.addChild(devantGauche);
  devant.addChild(devantHaut);
  devant.addChild(devantPorte);
  devant.addChild(tableau);

  PShape arriere = createShape(GROUP);
  PShape porteArriere = new Rectangle(-taille, -taille*11, -taille*5, taille*2, taille/10, taille*4 + taille / 10, porteTex, beigeCol, 100).dessiner();
  PShape arriereGauche = new Rectangle(-taille, 0, -taille*5, -taille*9, taille/10, taille*5 + taille/10, blancTex, beigeCol, 100).dessiner();
  PShape arriereDroite = new Rectangle(-taille, taille*-11, -taille*5, -taille, taille/10, taille*5 + taille/10, blancTex, beigeCol, 100).dessiner();
  PShape arriereHaut = new Rectangle(-taille, taille*-9, -taille + taille/10, -taille*2, taille/10, taille, blancTex, beigeCol, 100).dessiner();
  arriere.addChild(porteArriere);
  arriere.addChild(arriereGauche);
  arriere.addChild(arriereDroite);
  arriere.addChild(arriereHaut);

  PShape droite = createShape(GROUP);
  PShape droiteDroite = new Rectangle(-taille, 0, -taille*5, taille/10, taille*12 + taille/2, taille*5 + taille/10, blancTex, beigeCol, 100).dessiner();
  PShape droiteGauche = new Rectangle(-taille*-13 + taille/2, 0, -taille*5, taille/10, taille/2, taille*5 + taille/10, blancTex, beigeCol, 100).dessiner();
  PShape droiteHaut = new Rectangle(-taille*-11 + taille/2, 0, -taille + taille/10, taille/10, taille*2, taille*1, blancTex, beigeCol, 100).dessiner();
  PShape porteDroite = new Rectangle(taille*12 - taille/2, 0, -taille*5, taille/10, taille*2, taille*4 + taille/10, porteTex, beigeCol, 100).dessiner();
  droite.addChild(porteDroite);
  droite.addChild(droiteDroite);
  droite.addChild(droiteGauche);
  droite.addChild(droiteHaut);

  PShape gauche = createShape(GROUP);
  PShape gaucheHaut = new Rectangle(taille, -taille*12, -taille/2 + taille/4 + taille/20, taille/10, taille*11, taille/3, blancTex, beigeCol, 100).dessiner();
  PShape gaucheBas = new Rectangle(taille, -taille*12, -taille*5, taille/10, taille*11, taille*2 - taille/5 + taille/30, blancTex, beigeCol, 100).dessiner();
  PShape gaucheDroite = new Rectangle(-taille, -taille*12, -taille*5, taille/10, taille*2, taille*5 + taille/10, blancTex, beigeCol, 100).dessiner();
  PShape gaucheGauche = new Rectangle(taille*12, -taille*12, -taille*5, taille/10, taille*2, taille*5 + taille/10, blancTex, beigeCol, 100).dessiner();
  PShape baie = new Rectangle(taille, -taille*12, -taille*3 - taille/5 + taille/30, taille/10, taille*11, taille*3 - taille/20, blancTex, verre, 1000).dessiner();
  PShape chauffage = new Rectangle(taille*5, -taille*12 + taille/10, -taille*4 - taille/2 + taille/30, taille/5, taille*5, taille, loadImage("ressources/radiateur.png"), color(240, 240, 240), 1000).dessiner();
  PShape pillier = new Rectangle(taille*4 + taille/2, -taille*12, -taille*5 - taille/40, taille/2, taille, taille*6 + -18*taille/20, blancTex, beigeCol, 100).dessiner();
  PShape croisillonHaut = new Rectangle(taille, -taille*12, -taille + -taille/5, taille/8, taille*11, taille/4, blancTex, noirCol, 1000).dessiner();
  PShape croisillonGauche = new Rectangle(taille*2 + taille/2, -taille*12, -taille*3 + taille/-6, taille/8, taille/3, taille*2 - taille/20, blancTex, noirCol, 1000).dessiner();
  PShape croisillonDroite = new Rectangle(taille*9 + taille/2, -taille*12, -taille*3 + taille/-6, taille/8, taille/3, taille*2 - taille/20, blancTex, noirCol, 1000).dessiner();
  PShape croisillonGrand = new Rectangle(taille*7 + taille/2, -taille*12, -taille*3 + taille/-6, taille/8, taille/3, taille*3 - taille/20, blancTex, noirCol, 1000).dessiner();
  gauche.addChild(gaucheHaut);
  gauche.addChild(gaucheBas);
  gauche.addChild(gaucheGauche);
  gauche.addChild(gaucheDroite);
  gauche.addChild(chauffage);
  gauche.addChild(pillier);
  gauche.addChild(croisillonGauche);
  gauche.addChild(croisillonDroite);
  gauche.addChild(croisillonGrand);
  gauche.addChild(croisillonHaut);
  gauche.addChild(baie);

  textureWrap(CLAMP);

  murs.addChild(sol);
  murs.addChild(arriere);
  murs.addChild(devant);
  murs.addChild(plafond);
  murs.addChild(droite);
  murs.addChild(gauche);
  murs.rotateY(radians(270));
  murs.rotateZ(radians(270));
  murs.rotateX(radians(-180));
  return murs;
}
