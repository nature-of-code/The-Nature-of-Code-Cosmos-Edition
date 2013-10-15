
PShape universe;
float partSize = 20;
PImage sprite;  
Table hyg;

void setup() {
  size(640, 480, P3D);
  sprite = loadImage("star.png");
  universe = createShape(GROUP);

  hyg = loadTable("hygxyz.csv", "header");
  println("Database total stars: " + hyg.getRowCount());
  for (TableRow row : hyg.rows()) {
    float cx = row.getFloat("X"); 
    float cy = row.getFloat("Y"); 
    float cz = row.getFloat("Z");

    float d = sqrt(cx*cx+cy*cy+cz*cz);

    if (d < 50) {
      PShape part = createShape();

      part.beginShape(POINTS);
      part.stroke(255);
      part.strokeWeight(1);
      part.vertex(cx, cy, cz);
      part.endShape();
      universe.addChild(part);
    }
  }

  // Writing to the depth buffer is disabled to avoid rendering
  // artifacts due to the fact that the particles are semi-transparent
  // but not z-sorted.
  hint(DISABLE_DEPTH_MASK);
}

void draw() {
  background(0);

  float z = map(mouseX, 0, width, -5000, 5000);
  float ry = map(mouseY, 0, height, 0, TWO_PI);

  translate(width/2, height/2, 0);
  //rotateY(ry);

  stroke(255, 255, 0);
  fill(255,255,0);
  sphere(16);
  shape(universe);
}

