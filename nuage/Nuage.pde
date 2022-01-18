class Nuage {
int taille;

  Nuage(int taille) {
    this.taille = taille;
  }
  
  PShape dessiner(int x, int y, int z) {
    PShape nuage = createShape(GROUP);
      PShape one = sphere(5);
    nuage.addChild(one);
    
    return nuage;
  }
  
  PShape sphere(int inc) {
      PShape tr = recTriangle(inc, new PVector(-taille/2, -taille/2, taille/2), new PVector(taille/2, -taille/2, -taille/2), new PVector(-taille/2, taille/2, -taille/2));
      PShape tr2 = recTriangle(inc, new PVector(-taille/2, -taille/2, taille/2), new PVector(taille/2, -taille/2, -taille/2), new PVector(taille/2, taille/2, taille/2));      // NEW NEW TETRAETDRE DRAW
      PShape tr3 = recTriangle(inc, new PVector(taille/2, taille/2, taille/2), new PVector(taille/2, -taille/2, -taille/2), new PVector(-taille/2, taille/2, -taille/2));
      PShape tr4 = recTriangle(inc, new PVector(taille/2, taille/2, taille/2), new PVector(-taille/2, -taille/2, taille/2), new PVector(-taille/2, taille/2, -taille/2));
      return tetraedre(tr, tr2, tr3, tr4);
  }
  
  PShape recTriangle(int n, PVector a, PVector b, PVector c) {
    PShape gp = createShape(GROUP);
    if (n > 0) {
      gp.addChild(recTriangle(n-1, new PVector((a.x + b.x)/2, (a.y + b.y)/2, (a.z + b.z)/2), new PVector((b.x + c.x)/2, (b.y + c.y)/2, (b.z + c.z)/2), new PVector((c.x + a.x)/2, (c.y + a.y)/2, (c.z + a.z)/2)));
      gp.addChild(recTriangle(n-1, a, new PVector((a.x + c.x)/2, (a.y + c.y)/2, (a.z + c.z)/2), new PVector((b.x + a.x)/2, (b.y + a.y)/2, (b.z + a.z)/2)));
      gp.addChild(recTriangle(n-1, new PVector((b.x + a.x)/2, (b.y + a.y)/2, (b.z + a.z)/2), b, new PVector((b.x + c.x)/2, (b.y + c.y)/2, (b.z + c.z)/2)));
      gp.addChild(recTriangle(n-1, new PVector((b.x + c.x)/2, (b.y + c.y)/2, (b.z + c.z)/2), new PVector((a.x + c.x)/2, (a.y + c.y)/2, (a.z + c.z)/2), c));
    } else {
      return triangle(a, b, c);
    }
    return gp;
  }

  PShape tetraedre(PShape a, PShape b, PShape c, PShape d) {
    PShape tetra = createShape(GROUP);
    tetra.addChild(a);
    tetra.addChild(b);
    tetra.addChild(c);
    tetra.addChild(d);
    return tetra;
  }
  
  PShape triangle(PVector a, PVector b, PVector c) {
  a = a.copy().normalize().mult(taille);
  b = b.copy().normalize().mult(taille);
  c = c.copy().normalize().mult(taille);
  PVector an = a.copy().normalize();
  PVector bn = b.copy().normalize();
  PVector cn = c.copy().normalize();
  PShape triangle = createShape();
  triangle.beginShape(TRIANGLE_STRIP);
    triangle.noStroke();
    triangle.shininess(500);      // Reflective plus c'est haut
    triangle.fill(255, 255, 255);
    
    triangle.normal(an.x, an.y, an.z);
    triangle.vertex(a.x, a.y, a.z, 1, 0);
    
    triangle.normal(bn.x, bn.y, bn.z);
    triangle.vertex(b.x, b.y, b.z, 0, 1);
    
    triangle.normal(cn.x, cn.y, cn.z);
    triangle.vertex(c.x, c.y, c.z, 1, 1);
    
  triangle.endShape();
  return triangle;
}
}
