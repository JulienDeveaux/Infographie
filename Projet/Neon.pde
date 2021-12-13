class Neon {
  int taille;
  int e1, e2, e3;
  
  Neon(int taille) {
    this.taille = taille;
    e1 = 200;
    e2 = 200;
    e3 = 200;
  }
  
  Neon setEmissive(int e1, int e2, int e3) {
    this.e1 = e1;
    this.e2 = e2;
    this.e3 = e3;
    return this;
  }
  
  PShape dessiner(int x, int y , int z) {
    PImage blanc = loadImage("ressources/blanc.png");
    color t = color(100, 255, 255);
    int mat = 10000;
    PShape neon = new Rectangle(x + taille/10, y - taille + taille/2, z + taille*12, taille, taille/10, taille/2, blanc, t, mat)/*.setEmissive(e1, e2, e3)*/.setBas(loadImage("ressources/bois.png")).dessiner();     //emissive remove la texture
    
    
    neon.rotateY(radians(-270));
    neon.rotateZ(radians(90));
    neon.rotateX(radians(180));
    return neon;
  }
}

/*
Problèmes
  -texture néon perturbé par la lumière / emissive cache la texture
  -retirer les edges créé des gaps
  -la lumière est placé super haut pour voir le plafond
  -faire une tex noire pour l'écran tactile
*/
