class Chaise {
  int taille;
  boolean invert = false;
  
  Chaise(int taille) {
    this.taille = taille;
  }
  
  Chaise invert(boolean b) {
    invert = b;
    return this;
  }
  
  PShape dessiner(int x, int y, int z){
    PImage blanc = loadImage("ressources/blanc.png");
    PImage bois = loadImage("ressources/bois.png");
    color jaune = color(255, 238, 0);
    color dim = color(150, 150, 150);
    int reflective = 5;
    int mat = 10000;
    PShape chaise = createShape(GROUP);
    
    PShape assise = new Rectangle(x, y, z-taille/20, taille/20, taille, taille, bois, dim, mat).dessiner();
    
    PShape pied1 = new Rectangle(x, y + taille/20, z - taille/20, taille*(3/2), taille/20, taille/20, blanc, jaune, reflective).dessiner();
    PShape pied2 = new Rectangle(x + taille - taille/20, y + taille/20, z - taille/20, taille*(3/2), taille/20, taille/20, blanc, jaune, reflective).dessiner();
    PShape pied3 = new Rectangle(x + taille - taille/20, y + taille/20, z + taille - 2*taille/20, taille*(3/2), taille/20, taille/20, blanc, jaune, reflective).dessiner();
    PShape pied4 = new Rectangle(x, y + taille/20, z + taille - 2*taille/20, taille*(3/2), taille/20, taille/20, blanc, jaune, reflective).dessiner();
    
    PShape appuiDossier1;
    PShape appuiDossier2;
    PShape dossier;
    if(invert == false) {
      appuiDossier1 = new Rectangle(x + taille/4, y - taille, z - taille/20, taille*(3/2), taille/30, taille/30, blanc, jaune, reflective).dessiner();
      appuiDossier2 = new Rectangle(x + (3*taille/4), y - taille, z - taille/20, taille*(3/2), taille/30, taille/30, blanc, jaune, reflective).dessiner();
    
      dossier = new Rectangle(x + taille/7, y - taille, z, 2*taille/4, 3*taille/4, taille/20, bois, dim, mat).dessiner();
    } else {
      appuiDossier1 = new Rectangle(x + taille/4, y - taille, z + taille + taille/20, taille*(3/2), taille/30, taille/30, blanc, jaune, reflective).dessiner();
      appuiDossier2 = new Rectangle(x + (3*taille/4), y - taille, z + taille + taille/20, taille*(3/2), taille/30, taille/30, blanc, jaune, reflective).dessiner();
    
      dossier = new Rectangle(x + taille/7, y - taille, z + taille, 2*taille/4, 3*taille/4, taille/20, bois, dim, mat).dessiner();
    }

    chaise.addChild(assise);
    chaise.addChild(pied1);
    chaise.addChild(pied2);
    chaise.addChild(pied3);
    chaise.addChild(pied4);
    chaise.addChild(appuiDossier1);
    chaise.addChild(appuiDossier2);
    chaise.addChild(dossier);
    chaise.rotateX(radians(90));
    chaise.rotateY(radians(180));
    chaise.rotateZ(radians(90));
    return chaise;
  }
}
