import codeanticode.planetarium.*;

DomeCamera camera;
float cubeX, cubeY;
boolean grid = false;

void setup() {
  // For the time being, only use square windows  
  size(600, 600, Dome.RENDERER);
  camera = new DomeCamera(this);
}

// Called one time per frame.
void pre() {
  // The dome projection is centered at (0, 0), so the mouse coordinates
  // need to be offset by (width/2, height/2)
  cubeX += ((mouseX - width * 0.5) - cubeX) * 0.2;
  cubeY += ((mouseY - height * 0.5) - cubeY) * 0.2;
}

// Called five times per frame.
void draw() {
  int face = camera.getFace();
  if (face == DomeCamera.POSITIVE_X) {
    background(240, 59, 31);
  } else if (face == DomeCamera.NEGATIVE_X) {
    background(240, 146, 31);
  } else if (face == DomeCamera.POSITIVE_Y) {
    background(30, 245, 0);
  } else if (face == DomeCamera.NEGATIVE_Y) {
    background(30, 232, 156);
  } else if (face == DomeCamera.POSITIVE_Z) {
    background(52, 148, 206);
  } else if (face == DomeCamera.NEGATIVE_Z) {
    background(183, 115, 13);
  }
  
  pushMatrix();  
  translate(width/2, height/2, 300);
  
  stroke(255);
  noFill();
  
  pushMatrix();
  translate(cubeX, cubeY, 0);
  sphereDetail(8);
  sphere(30);
  popMatrix();
  
  int linesAmount = 10;
  for (int i = 0; i < linesAmount;i++) {
    float ratio = (float)i/(linesAmount-1);
    line(0, 0, cos(ratio*TWO_PI) * 50, sin(ratio*TWO_PI) * 50);
  }
  
  popMatrix();
}

void keyPressed() {
  grid = !grid;
  if (grid) camera.setMode(Dome.GRID);
  else camera.setMode(Dome.NORMAL);  
}