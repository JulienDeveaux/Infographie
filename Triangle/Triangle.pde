PShape triangle;

void setup() {
  size(400, 400, P3D);
  
  triangle = createShape();
  triangle.beginShape(TRIANGLES);
    triangle.fill(color(255, 0, 0));
    triangle.vertex(-100, 100, 0);
    triangle.fill(color(0, 255, 0));
    triangle.vertex(100, 100, 0);
    triangle.fill(color(0, 0, 255));
    triangle.vertex(0, -100, 0);
  triangle.endShape();
  noLoop();
}

void draw() {
  background(0);
  camera(0, 0, 300, 0, 0, 0, 0, 1, 0);
  shape(triangle);
}
