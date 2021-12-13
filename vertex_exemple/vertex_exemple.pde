void setup() {
    size(880, 210, P3D);
    frameRate(3);
}

void draw() {
    carreSimple(10, 10);
    carreNonFerme(120, 10);
    plusieursCarres(230, 10);   
    polygone(340, 10);
    triangles(450, 10);
    triangleStrip(560, 10);
    triangleFan(670, 10);
    cercleTriangle(825, 60, 50, 12);
}


void carreSimple(int x, int y) {
    stroke(0);
    fill(255, 0, 0);
    beginShape();
        vertex(x, y);
        vertex(x+100, y);
        vertex(x+100, y+100);
        vertex(x, y+100);
    endShape(CLOSE);
}

void carreNonFerme(int x, int y) {
  stroke(0);
  noFill();
  // Un carré simple
  beginShape();
    vertex(x, y);
    vertex(x+100, y);
    vertex(x+100, y+100);
    vertex(x, y+100);
  endShape();
}

void plusieursCarres(int x, int y) {
  stroke(0);
  fill(255, 200, 40);
  beginShape(QUADS);    // pour des figures séparées (par 4 vertex)
    // Premier carré
    vertex(x, y);
    vertex(x+50, y);
    vertex(x+50, y+50);
    vertex(x, y+50);
    // Deuxième carré
    vertex(x+50, y+50);
    vertex(x+100, y+50);
    vertex(x+100, y+100);
    vertex(x+50, y+100);
  endShape();
}

void polygone(int x, int y) {
  stroke(0);
  fill(50, 230, 120);
  beginShape();
    vertex(x, y);
    vertex(x+100, y+20);
    vertex(x+90, y+80);
    vertex(x+10, y+90);
  endShape(CLOSE);
}

void triangles(int x, int y) {
  stroke(0);
  fill(200, 40, 230);
  beginShape(TRIANGLES);
    vertex(x+25, y);
    vertex(x+50, y+50);
    vertex(x, y+50);
    vertex(x+75, y+50);
    vertex(x+100, y+100);
    vertex(x+50, y+100);
  endShape();
}

void triangleStrip(int x, int y) {
  stroke(0);
  fill(40, 180, 220);
  beginShape(TRIANGLE_STRIP);
    vertex(x, y);
    vertex(x, y+100);
    vertex(x+50, y);
    vertex(x+50, y+100);
    vertex(x+100, y);
    vertex(x+100, y+100);
  endShape();
}

void triangleFan(int x, int y) {
  stroke(0);
  fill(60, 230, 160);
  beginShape(TRIANGLE_FAN);
    vertex(x, y+100);
    vertex(x, y);
    vertex(x+50, y);
    vertex(x+100, y);
    vertex(x+100, y+50);
    vertex(x+100, y+100);
  endShape();
}

void cercleTriangle(float x, float y, float rayon, int nb) {
  noStroke();
  fill(0, 255, 0);
  beginShape(TRIANGLE_FAN);
    /*for(float i = 0; i < 1; i+=0.1) {
      vertex(cos(i+PI/4) * rayon + x, sin(i+PI/4) * rayon + y);
      vertex(cos(i+5*PI/6) * rayon + x, sin(i+5*PI/6) * rayon + y);
      vertex(cos(i+4*PI/3) * rayon + x, sin(i+4*PI/3) * rayon + y);
    }*/
    vertex(x + rayon, y);
    for(float a = 0; a <= TWO_PI; a += (TWO_PI/nb)) {
      vertex(cos(a) * rayon + x, sin(a) * rayon + y);
    }
  endShape();
 }
