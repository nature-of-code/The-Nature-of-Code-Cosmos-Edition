
PShape universe;
float partSize = 20;
PImage sprite;  

void setup() {
  size(640, 480, P3D);
  sprite = loadImage("star.png");
  universe = createShape(GROUP);

  Table hyg = loadTable("hygxyz.csv", "header");
  println("Database total stars: " + hyg.getRowCount());
  for (TableRow row : hyg.rows()) {
    float cx = row.getFloat("X"); 
    float cy = row.getFloat("Y"); 
    float cz = row.getFloat("Z");
    PShape part = createShape();
    part.beginShape(QUAD);
    part.noStroke();
    part.tint(255);
    part.texture(sprite);
    part.normal(0, 0, 1);
    part.vertex(cx - partSize/2, cy - partSize/2, cz, 0, 0);
    part.vertex(cx + partSize/2, cy - partSize/2, cz, sprite.width, 0);
    part.vertex(cx + partSize/2, cy + partSize/2, cz, sprite.width, sprite.height);
    part.vertex(cx - partSize/2, cy + partSize/2, cz, 0, sprite.height);    
    part.endShape();    
    universe.addChild(part);
  }

  // Writing to the depth buffer is disabled to avoid rendering
  // artifacts due to the fact that the particles are semi-transparent
  // but not z-sorted.
  hint(DISABLE_DEPTH_MASK);
}

void draw() {
  background(0);
  translate(width/2, height/2);
  rotateY(frameCount * 0.01);

  shape(universe);
  println(frameRate);
}

