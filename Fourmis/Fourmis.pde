Vecteur2D[] fourmis = {
  new Vecteur2D(100, 100),
  new Vecteur2D(500, 100),
  new Vecteur2D(500, 500),
  new Vecteur2D(100, 500)
};

PShape carre;
int nbIter = 100;
float v = 0.1; 
float alpha;
float facteur;

void setup() {
   size(600, 600);
   carre = creerCarre(500);
   alpha = atan(v / (1 - v));
   facteur = sqrt((1 - v) * (1 - v) +  v * v);
}

PShape creerCarre(int cote) {
  PShape carre = createShape();
  
  carre.beginShape();
    carre.stroke(0, 0, 0, 32);
    carre.vertex(-cote/2, -cote/2);
    carre.vertex( cote/2, -cote/2);
    carre.vertex( cote/2,  cote/2);
    carre.vertex(-cote/2,  cote/2);
  carre.endShape(CLOSE);
  
  return carre;
}

void draw() {
  if(v < 1) {
    v+=0.001;
  }else {
    v =0.1;
  }
  alpha = atan(v / (1 - v));
  facteur = sqrt((1 - v) * (1 - v) +  v * v);
  background(200);
  stroke(0);
  colorMode(HSB, nbIter, 1, nbIter);  
  translate(width / 2, height / 2);
  for(int i = 1; i < nbIter; i++) {
    carre.setFill(color(i, 0.7, nbIter - i));
    shape(carre);
    scale(facteur);
    rotate(alpha);
  }

  
  /*    Moi
  beginShape();
  for(int i  = 0; i < 4; i++) {
    vertex(fourmis[i].x, fourmis[i].y);
  }
  endShape(CLOSE);
  Vecteur2D[] vertexCarre = new Vecteur2D[fourmis.length];
  for(int i = 0; i < fourmis.length; i++) {
    vertexCarre[i] = fourmis[i].plus(new Vecteur2D(fourmis[i], fourmis[i < fourmis.length - 1 ? i + 1 : 0]).mult(0.1));
  }
  fourmis = vertexCarre;
  beginShape();
  for(int i  = 0; i < 4; i++) {
    vertex(vertexCarre[i].x, vertexCarre[i].y);
  }
  endShape(CLOSE);*/
}
