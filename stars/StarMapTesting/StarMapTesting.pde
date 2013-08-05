
PImage star;
PShape part;
ArrayList<Star> universe;

void setup() {
  size(640, 480, P3D);
  star = loadImage("star.png");
  universe = new ArrayList<Star>();
  Table hyg = loadTable("hygxyz.csv", "header");
  println("Database total stars: " + hyg.getRowCount());
  for (TableRow row : hyg.rows()) {
    stroke(255);
    float x = row.getFloat("X"); 
    float y = row.getFloat("Y"); 
    float z = row.getFloat("Z");
    universe.add(new Star(x, y, z));
  }
  
  float partSize = 20;
  part = createShape();
  part.beginShape(QUAD);
  part.noStroke();
  part.tint(255);
  part.texture(star);
  part.normal(0, 0, 1);
  part.vertex(- partSize/2, - partSize/2, 0, 0, 0);
  part.vertex(  partSize/2, - partSize/2, 0, star.width, 0);
  part.vertex(  partSize/2, partSize/2, 0, star.width, star.height);
  part.vertex(- partSize/2, partSize/2, 0, 0, star.height);    
  part.endShape();    

  // Writing to the depth buffer is disabled to avoid rendering
  // artifacts due to the fact that the particles are semi-transparent
  // but not z-sorted.
  hint(DISABLE_DEPTH_MASK);
}

void draw() {
  background(0);
  translate(width/2, height/2);
  rotateY(frameCount * 0.01);

  for (Star s : universe) {
    s.display();
  }

  println(frameRate);
}

