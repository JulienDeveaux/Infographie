PShape comp;

void setup() {
  size(600, 600, P3D);
  comp = creerComposite();
}

void draw() {
  background(210);
  translate(mouseX, mouseY);
  shape(comp);
}

PShape creerComposite() {
  PShape group = createShape(GROUP);
  PShape cercle = createShape(ELLIPSE, 0, 0, 100, 100);
  PShape oeil1 = createShape(ELLIPSE, 0, 0, 30, 70);
  PShape oeil2 = createShape(ELLIPSE, 0, 0, 30, 70);
  PShape iris1 = createShape(ELLIPSE, 0, 0, 20, 20);
  PShape iris2 = createShape(ELLIPSE, 0, 0, 20, 20);
  
  iris1.setFill(color(0));
  iris2.setFill(color(0));
  oeil1.setFill(color(255));
  oeil2.setFill(color(255));
  cercle.setFill(color(255, 255, 0));
  
  oeil1.translate(-20, 0, 0);
  oeil2.translate( 20, 0, 0);
  iris1.translate(-15, 0, 0);
  iris2.translate( 15, 0, 0);
  
  group.addChild(cercle);
  group.addChild(oeil1);
  group.addChild(oeil2);
  group.addChild(iris1);
  group.addChild(iris2);
  
  return group;
}
