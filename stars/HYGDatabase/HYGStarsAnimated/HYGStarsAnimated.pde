// NOC Cosmos
// https://github.com/shiffman/The-Nature-of-Code-Cosmos-Edition

// About the data: http://www.astronexus.com/node/34

// PShape to hold everything
PShape universe;
// Particle size and texture
float partSize = 4;
PImage sprite;  

void setup() {
  size(640, 480, P3D);
  sprite = loadImage("star.png");
  // A group PShape
  universe = createShape(GROUP);
  
  // Parse all the data
  Table hyg = loadTable("hygxyz.csv", "header");
  println("Database total stars: " + hyg.getRowCount());
  for (TableRow row : hyg.rows()) {
    float cx = row.getFloat("X"); 
    float cy = row.getFloat("Y"); 
    float cz = row.getFloat("Z");
    PShape part = createShape();
    // Make each one a QUAD with a location
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
    
    // Could just be a point 
    /*part.beginShape(POINTS);
    part.stroke(255);
    part.strokeWeight(2);
    part.vertex(cx,cy,cz);
    part.endShape();*/
    // Add each to the univers
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
  // We are not billboarding so just rotate by Z
  rotateZ(frameCount * 0.001);
  // Draw the whole thing
  shape(universe);
  println(frameRate);
}

