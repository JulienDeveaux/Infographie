class Table {
  int taille;
  boolean dessineOrdis = true;
  
  Table(int taille) {
    this.taille = taille;
  }
  
  Table dessinerOrdis(boolean b) {
    dessineOrdis = b;
    return this;
  }
  
  PShape dessiner(int x, int y, int z){
    PImage blanc = loadImage("ressources/blanc.png");
    PImage grille = loadImage("ressources/grille.png");
    PImage ecranImg = loadImage("ressources/ecran.png");
    PImage clavierImg = loadImage("ressources/clavier.png");
    color t = color(255, 238, 0);
    color tn = color(0, 0, 0);
    int reflective = 10;
    int mat = 10000;
    PShape table = createShape(GROUP);
    
    PShape plateau = new Rectangle(x, y, z, taille/10, taille*3, taille, loadImage("ressources/bleu.png"), color(255, 255, 255), mat).dessiner();
    
    PShape pied1 = new Rectangle(x, y + taille/10, z, taille*(3/2) + taille/2, taille/20, taille/20, blanc, tn, reflective).dessiner();
    PShape pied2 = new Rectangle(x + taille*3 - taille/20, y + taille/10, z, taille*(3/2) + taille/2, taille/20, taille/20, blanc, tn, reflective).dessiner();
    PShape pied3 = new Rectangle(x + taille*3 - taille/20, y + taille/10, z + taille - taille/20, taille*(3/2) + taille/2, taille/20, taille/20, blanc, tn, reflective).dessiner();
    PShape pied4 = new Rectangle(x, y + taille/10, z + taille - taille/20, taille*(3/2) + taille/2, taille/20, taille/20, blanc, tn, reflective).dessiner();
    
    PShape ecran1 = new Rectangle(x + taille*2/3, y - taille*2/3, z + taille - taille/5, taille - taille/3, taille - taille/8, taille/20, blanc, color(50, 50, 50), mat).setFront(ecranImg).dessiner();
    PShape ecran2 = new Rectangle(x + taille*5/3, y - taille*2/3, z + taille - taille/5, taille - taille/3, taille - taille/8, taille/20, blanc, color(50, 50, 50), mat).setFront(ecranImg).dessiner();
    
    PShape ecranStand1 = new Rectangle(x + taille, y - taille/4, z + taille - taille/6, taille/5, taille/4, taille/10, blanc, color(20, 20, 20), mat).dessiner();
    PShape ecranStand2 = new Rectangle(x + 2*taille, y - taille/4, z  + taille - taille/6, taille/5, taille/4, taille/10, blanc, color(20, 20, 20), mat).dessiner();

    PShape clavier1 = new Rectangle(x + taille*2/3, y - taille/20, z + taille/10, taille/20, taille - taille/10, taille/2, blanc, color(255, 255, 255), mat).setHaut(clavierImg).dessiner();
    PShape clavier2 = new Rectangle(x + taille*5/3 - taille/20, y - taille/20, z + taille/10, taille/20, taille - taille/10, taille/2, blanc, color(255, 255, 255), mat).setHaut(clavierImg).dessiner();
    
    PShape pc1 = new Rectangle(x + taille/4, y - taille/2, z + taille/2, taille/2, taille/3, taille/2, blanc, color(30, 30, 30), mat).setFront(grille).dessiner();
    PShape pc2 = new Rectangle(x + taille*5/2 + taille/10, y - taille/2, z + taille/2, taille/2, taille/3, taille/2, blanc, color(30, 30, 30), mat).setFront(grille).dessiner();
    
    table.addChild(plateau);
    table.addChild(pied1);
    table.addChild(pied2);
    table.addChild(pied3);
    table.addChild(pied4);
    if(dessineOrdis == true) {
      table.addChild(ecran1);
      table.addChild(ecranStand1);
      table.addChild(clavier1);
      table.addChild(pc1);
      table.addChild(ecran2);
      table.addChild(ecranStand2);
      table.addChild(clavier2);
      table.addChild(pc2);
    }
    table.rotateX(radians(90));
    table.rotateY(radians(180));
    table.rotateZ(radians(90));
    return table;
  }
}
