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
    color t = color(200, 200, 200);
    int mat = 10000;
    println(x + " " + y + " " + z);
    PShape neon = new Rectangle(x + taille/10, y - taille*1 + taille/2, z + taille*12, taille, taille/10, taille/2, blanc, t, mat).setEmissive(e1, e2, e3).setBas(loadImage("ressources/neon.png")).dessiner();
    
    
    neon.rotateY(radians(-270));
    neon.rotateZ(radians(90));
    neon.rotateX(radians(180));
    return neon;
  }
}
