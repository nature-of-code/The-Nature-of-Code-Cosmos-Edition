
Table hyg;

void setup() {
  size(640, 480, P3D);

  hyg = loadTable("hygxyz.csv","header");
  println(hyg.getRowCount());
}

void draw() {
  background(0);
  translate(width/2,height/2);
  for (TableRow row : hyg.rows()) {
    stroke(255);
    float x = row.getFloat("X"); 
    float y = row.getFloat("Y"); 
    float z = row.getFloat("Z");
    point(x, y, z);
  }
  
  fill(255,255,0);
  noStroke();
  sphere(12);
  noLoop();
}

