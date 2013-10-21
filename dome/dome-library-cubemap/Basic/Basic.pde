// The planetarium library is designed to create real-time projections on 
// spherical domes. It is based on the FullDome project by Christopher 
// Warnow (ch.warnow@gmx.de):
// https://github.com/mphasize/FullDome
//
// A brief descrition on how it works: a 360° view of the scene is generated
// by rendering the scene 6 times from each direction: positive x, negative x, 
// positive y, and so on. The output of each rendering is stored inside a cube map 
// texture, which is then applied on a sphere representing the dome.
// Hence, the library calls the draw() method 6 times per frame in order to update  
// the corresponding side of the cube map texture (in reality, only 5 times since  
// the bottom side of the cube map is not invisible on the dome). 
// So, it is important to keep in mind that if you need to perform some calculation
// only one time per frame, then the code for those calculations should be put inside
// the pre() method.

import codeanticode.planetarium.*;

float cubeX, cubeY, cubeZ;

void setup() {
  // For the time being, only use square windows  
  size(600, 600, Dome.RENDERER);
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
  background(0);
  
  pushMatrix();  
  translate(width/2, height/2, 300);
  
  lights();
  
  stroke(0);  
  fill(150);
  pushMatrix();
  translate(cubeX, cubeY, cubeZ);  
  box(50);
  popMatrix();

  stroke(255);
  int linesAmount = 10;
  for (int i = 0; i < linesAmount;i++) {
    float ratio = (float)i/(linesAmount-1);
    line(0, 0, cos(ratio*TWO_PI) * 50, sin(ratio*TWO_PI) * 50);
  }
  popMatrix();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) cubeZ -= 5;
    else if (keyCode == DOWN) cubeZ += 5;
  }  
}