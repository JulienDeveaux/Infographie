PShape horloge;
PShape heure;
PShape minute;
TimeMillis time;

void setup() {
  size(500, 500);
  time = new TimeMillis();
  horloge = creerHorloge();
  minute = creerAiguille(180, color(255, 0, 0));
  heure = creerAiguille(150, color(255, 255, 0));
  frameRate(60);
  pixelDensity(displayDensity());
  hint(DISABLE_DEPTH_TEST);
}

void draw() {
  background(255);
  
  PShape trotteuse = createShape(RECT, 0, 0, 5, -190);
  trotteuse.rotate(time.s() * TWO_PI / 12 / 5 * 60);
  trotteuse.setFill(color(255, 0, 255));
  trotteuse.setStroke(color(255, 0, 255));
  
  PShape pointCentral = createShape(ELLIPSE, 0, 0, 10, 10);
  pointCentral.setFill(255);

  translate(height / 2, width / 2);
  shape(horloge);
  pushMatrix();
    rotate(time.h() * TWO_PI / 12 / 5 * 60);
    shape(heure);
  popMatrix();
  pushMatrix();
    rotate(time.m() * TWO_PI / 12 / 5 * 60);
    shape(minute);
  popMatrix();
  shape(trotteuse);
  shape(pointCentral);
  
  /*fill(255, 0, 0);
  float secPrecis = second() + time.s();
  beginShape();        // trotteuse
    vertex(3, 0);
    vertex(0, 5);
    vertex(cos((secPrecis - 15) * TWO_PI/12/5) * (height / 2 - 60) - 1, sin((secPrecis - 15) * TWO_PI/12/5) * (height / 2 - 60));
    vertex(cos((secPrecis - 15) * TWO_PI/12/5) * (height / 2 - 60), sin((secPrecis - 15) * TWO_PI/12/5) * (height / 2 - 60) - 5);
    translate(height / 2, width / 2);
  endShape(CLOSE);
  
  //float seconds = second() / 10;
  float minPrecis = minute() + time.s();
  fill(255, 255, 0);
  beginShape();        // minutes
    vertex(0, 0);
    vertex(0, 0);
    vertex(cos((minPrecis - 15) * TWO_PI/12/5) * (height / 2 - 70) - 1, sin((minPrecis - 15) * TWO_PI/12/5) * (height / 2 - 70));
    vertex(cos((minPrecis - 15) * TWO_PI/12/5) * (height / 2 - 70), sin((minPrecis - 15) * TWO_PI/12/5) * (height / 2 - 70) - 5);
  endShape(CLOSE);
  
  float hour = hour();
  if(hour > 12) {
    hour -=12;
  }
  hour += time.m();
  fill(255, 0, 255);
  beginShape();        // heure
    vertex(0, 0);
    vertex(0, 0);
    vertex(cos((hour - 3) * TWO_PI/12) * (height / 2 - 100) - 1, sin((hour - 3) * TWO_PI/12) * (height / 2 - 100));
    vertex(cos((hour - 3) * TWO_PI/12) * (height / 2 - 100), sin((hour - 3) * TWO_PI/12) * (height / 2 - 100) - 5);
  endShape(CLOSE);*/
}

PShape creerHorloge() {
  PShape group = createShape(GROUP);
  PShape groupePoints = createShape(GROUP);
    
  PShape cadrant = createShape(ELLIPSE, 0, 0, height - 50, width - 50); 
  
  cadrant.setFill(color(230));
  
  for(float i = TWO_PI/12; i < TWO_PI; i += (TWO_PI/12)) {
    PShape h = createShape(ELLIPSE, cos(i) * (height / 2 - 50), sin(i) * (width / 2 - 50), 10, 10);
    h.setFill(color(255));
    groupePoints.addChild(h);
    
    PShape m1 = createShape(ELLIPSE, cos(i + TWO_PI/12/5) * (height / 2 - 50), sin(i + TWO_PI/12/5) * (width / 2 - 50), 5, 5);      //En cercle qui marchent bien du début
    PShape m2 = createShape(ELLIPSE, cos(i + 2*TWO_PI/12/5) * (height / 2 - 50), sin(i + 2*TWO_PI/12/5) * (width / 2 - 50), 5, 5);
    PShape m3 = createShape(ELLIPSE, cos(i + 3*TWO_PI/12/5) * (height / 2 - 50), sin(i + 3*TWO_PI/12/5) * (width / 2 - 50), 5, 5);
    PShape m4 = createShape(ELLIPSE, cos(i + 4*TWO_PI/12/5) * (height / 2 - 50), sin(i + 4*TWO_PI/12/5) * (width / 2 - 50), 5, 5);
    
    /*PShape m1 = createShape(RECT, cos(i + TWO_PI/12/5) * (height / 2 - 50), sin(i + TWO_PI/12/5) * (width / 2 - 50), 5, 5);           //En carré
    pushMatrix();
      translate(height / 2, width / 2);
      rotate(i*TWO_PI/12*5);
      shape(m1);
    popMatrix();
    PShape m2 = createShape(RECT, cos(i + 2*TWO_PI/12/5) * (height / 2 - 50), sin(i + 2*TWO_PI/12/5) * (width / 2 - 50), 5, 5);
    PShape m3 = createShape(RECT, cos(i + 3*TWO_PI/12/5) * (height / 2 - 50), sin(i + 3*TWO_PI/12/5) * (width / 2 - 50), 5, 5);
    PShape m4 = createShape(RECT, cos(i + 4*TWO_PI/12/5) * (height / 2 - 50), sin(i + 4*TWO_PI/12/5) * (width / 2 - 50), 5, 5);*/
    groupePoints.addChild(m1);
    groupePoints.addChild(m2);
    groupePoints.addChild(m3);
    groupePoints.addChild(m4);
    m1.setFill(color(255));
    m2.setFill(color(255));
    m3.setFill(color(255));
    m4.setFill(color(255));
}
  
  group.addChild(cadrant);
  group.addChild(groupePoints);
  
  return group;
}

PShape creerAiguille(int taille, color a) {
  PShape aiguille = createShape();
  aiguille.beginShape(TRIANGLE_STRIP);
  aiguille.fill(a);
  aiguille.vertex(-10, 0);
  aiguille.vertex(0, 20);
  aiguille.vertex(0, -taille);
  aiguille.vertex(10, 0);
  aiguille.noStroke();
  aiguille.endShape();
  return aiguille;
}
