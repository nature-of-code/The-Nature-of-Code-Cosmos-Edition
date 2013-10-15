// Adapted from https://github.com/natronics/ISS-photo-locations/

void setup() {
  /*
  size(1200, 600);
  float lata = -height / 180.0;
   float latb = height - (lata*-90.0);
   float lona = width / 360.0;
   float lonb = lona*180.0;
   
   background(255);
   for (int i = 1; i < 35; i++) {
   println("drawing mission " + i);
   Table mission = loadTable("ISS"+nf(i, 3)+".csv");
   for (TableRow row : mission.rows()) {
   float lat = row.getFloat(1);
   float lon = row.getFloat(2);
   noStroke();
   fill(0, 0, 0, 10);
   rect(lona*lon+lonb, lata*lat+latb, 2, 2);
   }
   }*/

  size(640,480,P3D);
  background(0);
  translate(width/2, height/2);
  for (int i = 1; i < 35; i++) {
    println("drawing mission " + i);
    Table mission = loadTable("ISS"+nf(i, 3)+".csv");
    for (TableRow row : mission.rows()) {
      float lat = row.getFloat(1) * PI/180;
      float lon = row.getFloat(2) * PI/180;
      float r = 200;
      PVector v = new PVector();
      v.x = -r*cos(lat)*cos(lon);
      v.y = -r * sin(lat);
      v.z = r * cos(lat) * sin(lon);
      pushMatrix();
      translate(v.x, v.y, v.z);
      stroke(255,20);
      point(0, 0);
      popMatrix();
    }
  }
}

void draw() {
  noLoop();
}

