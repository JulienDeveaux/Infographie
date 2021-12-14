class Neon {
  int taille;
  int e1, e2, e3;
  boolean isGrand = false;
  
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
  
  Neon isGrand(boolean b) {
    isGrand = b;
    return this;
  }
  
  PShape dessiner(int x, int y , int z) {
    PImage blanc = loadImage("ressources/blanc.png");
    PImage neonTex = loadImage("ressources/neon.png");
    color t = color(255, 255, 255);
    int mat = 10000;
    PShape neon;
    if(isGrand == true) {
       neon = new Rectangle(x + taille/10, y - taille + taille/2, z + taille*6, taille - taille/3, taille/10, taille*6, blanc, t, mat)/*.setEmissive(e1, e2, e3)*/.setBas(neonTex).dessiner();
    } else {
       neon = new Rectangle(x + taille/10, y - taille + taille/2, z + taille*12, taille, taille/10, taille/2, blanc, t, mat)/*.setEmissive(e1, e2, e3)*/.setBas(neonTex).dessiner();
    }
    
    neon.rotateY(radians(-270));
    neon.rotateZ(radians(90));
    neon.rotateX(radians(180));
    return neon;
  }
}

/*
Problèmes
  -texture néon perturbé par la lumière / emissive cache la texture      -> le shader :/
  -retirer les edges créé des gaps
A faire
  -croisillons
  -tables du fond
  -paysage ?
  -nuages et soleil en géode
  -camera
*/
