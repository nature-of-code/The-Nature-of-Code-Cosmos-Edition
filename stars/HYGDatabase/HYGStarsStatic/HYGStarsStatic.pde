// NOC Cosmos
// https://github.com/shiffman/The-Nature-of-Code-Cosmos-Edition

// About the data: http://www.astronexus.com/node/34

// A list of star objects
ArrayList<Star> universe;

void setup() {
  size(640, 480, P3D);
  universe = new ArrayList<Star>();
  // Parse data and just use xyz coordinates
  // There is lots more data there
  Table hyg = loadTable("hygxyz.csv", "header");
  println("Database total stars: " + hyg.getRowCount());
  for (TableRow row : hyg.rows()) {
    stroke(255);
    float x = row.getFloat("X"); 
    float y = row.getFloat("Y"); 
    float z = row.getFloat("Z");
    universe.add(new Star(x,y,z));
  }
}

void draw() {
  background(0);
  translate(width/2, height/2);
  for (Star s : universe) {
    s.display(); 
  }
  println(frameRate);
}

