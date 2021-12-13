class Rectangle {
  int x;
  int y;
  int z;
  int lon;
  int lar;
  int h;
  color t;
  int s;
  PImage front, back, gauche, droite, haut, bas;
  int e1, e2, e3;
  
  boolean b;
  
  Rectangle(int x, int y, int z, int lon, int lar, int h, PImage tex, color t, int s) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.lon = lon;
    this.lar = lar;
    this.h = h;
    this.t = t;
    this.s = s;
    front = tex;
    back = tex;
    gauche = tex;
    droite = tex;
    haut = tex;
    bas = tex;
    e1 = 0;
    e2 = 0;
    e3 = 0;
  }
  
  Rectangle setFront(PImage front) {
    this.front = front;
    return this;
  }
  
  Rectangle setBack(PImage back) {
    this.back = back;
    return this;
  }
  
  Rectangle setGauche(PImage gauche) {
    this.gauche = gauche;
    return this;
  }
  
  Rectangle setDroite(PImage droite) {
    this.droite = droite;
    return this;
  }
  
  Rectangle setHaut(PImage haut) {
    this.haut = haut;
    return this;
  }
  
  Rectangle setBas(PImage bas) {
    this.bas = bas;
    return this;
  }
  
  Rectangle setEmissive(int e1, int e2, int e3) {
    this.e1 = e1;
    this.e2 = e2;
    this.e3 = e3;
    return this;
  }
  
 PShape dessiner() {
  PShape cubeFinal = createShape(GROUP);
  
  PShape cube = createShape();
  cube.beginShape(QUADS);
    cube.texture(front);
    cube.textureMode(NORMAL);
    cube.shininess(s);
    cube.emissive(e1, e2, e3);
    cube.normal(0, 0, 1);
    cube.tint(t);
    cube.vertex(0 + x, 0 + y, 0 + z, 0, 0);    //front
    cube.vertex(0 + x, lon + y, 0 + z, 0, 1);
    cube.vertex(lar + x, lon + y, 0 + z, 1, 1);
    cube.vertex(lar + x, 0 + y, 0 + z, 1, 0);
  cube.endShape();
  
  PShape cube2 = createShape();
    cube2.beginShape(QUADS);
    cube2.texture(back);
    cube2.textureMode(NORMAL);
    cube2.shininess(s);
    cube2.emissive(e1, e2, e3);
    cube2.normal(0, 0, 1);
    cube2.tint(t);
    cube2.vertex(0 + x, 0 + y, h + z, 0, 0);    //back
    cube2.vertex(0 + x, lon + y, h + z, 0, 1);
    cube2.vertex(lar + x, lon + y, h + z, 1, 1);
    cube2.vertex(lar + x, 0 + y, h + z, 1, 0);
  cube2.endShape();
  
  PShape cube3 = createShape();
    cube3.beginShape(QUADS);
    cube3.texture(bas);
    cube3.textureMode(NORMAL);
    cube3.shininess(s);
    cube3.emissive(e1, e2, e3);
    cube3.normal(0, 0, 1);
    cube3.tint(t);
    cube3.vertex(0 + x, 0 + y, 0 + z, 0, 0);    //bas
    cube3.vertex(0 + x, 0 + y, h + z, 0, 1);
    cube3.vertex(0 + x, lon + y, h + z, 1, 1);
    cube3.vertex(0 + x, lon + y, 0 + z, 1, 0);
  cube3.endShape();
  
  PShape cube4 = createShape();
    cube4.beginShape(QUADS);
    cube4.texture(gauche);
    cube4.textureMode(NORMAL);
    cube4.shininess(s);
    cube4.emissive(e1, e2, e3);
    cube4.normal(0, 0, 1);
    cube4.tint(t);
    cube4.vertex(lar + x, 0 + y, 0 + z, 0, 0);    //gauche
    cube4.vertex(lar + x, 0 + y, h + z, 0, 1);
    cube4.vertex(lar + x, lon + y, h + z, 1, 1);
    cube4.vertex(lar + x, lon + y, 0 + z, 1, 0);
  cube4.endShape();
    
  PShape cube5 = createShape();
    cube5.beginShape(QUADS);
    cube5.texture(haut);
    cube5.textureMode(NORMAL);
    cube5.shininess(s);
    cube5.emissive(e1, e2, e3);
    cube5.normal(0, 0, 1);
    cube5.tint(t);
    cube5.vertex(0 + x, 0 + y, 0 + z, 0, 0);    // haut
    cube5.vertex(0 + x, 0 + y, h + z, 0, 1);
    cube5.vertex(lar + x, 0 + y, h + z, 1, 1);
    cube5.vertex(lar + x, 0 + y, 0 + z, 1, 0);
  cube5.endShape();
    
  PShape cube6 = createShape();
    cube6.beginShape(QUADS);
    cube6.texture(droite);
    cube6.textureMode(NORMAL);
    cube6.shininess(s);
    cube6.emissive(e1, e2, e3);
    cube6.normal(0, 0, 1);
    cube6.tint(t);
    cube6.vertex(0 + x, lon + y, 0 + z, 0, 0);    // droite
    cube6.vertex(0 + x, lon + y, h + z, 0, 1);
    cube6.vertex(lar + x, lon + y, h + z, 1, 1);
    cube6.vertex(lar + x, lon + y, 0 + z, 1, 0);
  cube6.endShape();
  
  cubeFinal.addChild(cube);
  cubeFinal.addChild(cube2);
  cubeFinal.addChild(cube3);
  cubeFinal.addChild(cube4);
  cubeFinal.addChild(cube5);
  cubeFinal.addChild(cube6);
  return cubeFinal;
 }
}
