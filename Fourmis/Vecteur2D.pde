class Vecteur2D {
  float x;
  float y;
  Vecteur2D(float x, float y) {
    this.x = x;
    this.y = y;
  }
  Vecteur2D(Vecteur2D that) {
    this.x = that.x;
    this.y = that.y;
  }
  Vecteur2D(Vecteur2D de, Vecteur2D a) {
    this.x = a.x - de.x;
    this.y = a.y - de.y;
  }
  float norme() { 
    return sqrt(x*x + y*y);
  }
  Vecteur2D normalise() {
    div(norme());
    return this;
  }
  Vecteur2D mult(float scalaire) {
    x *= scalaire;
    y *= scalaire;
    return this;
  }
  Vecteur2D div(float scalaire) {
    x /= scalaire;
    y /= scalaire;
    return this;
  }
  Vecteur2D plus(Vecteur2D that) {
    return new Vecteur2D(this.x + that.x, this.y + that.y);
  }
}
