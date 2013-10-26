// NOC Cosmos
// https://github.com/shiffman/The-Nature-of-Code-Cosmos-Edition

// Stars are all placed randomly on a very very large sphere
Star[] stars = new Star[1000];

// Size of taht sphere
float depth = 1000;

boolean rotate = false;

float rotX, rotY, rotZ;

void setup() {
  size(800, 600, P3D);
  for (int i=0; i<stars.length; i++) {
    stars[i] = new Star();
  }
}

void draw() {
  background(0);

  pushMatrix();
  translate(width/2, height/2);
  rotateX(rotY);
  rotateY(rotX);
  rotateZ(rotZ);

  lights();
  noStroke();
  fill(100);
  // Something in the middle for show
  sphere(40);
  
  // Draw everything
  for (Star s : stars) {
    s.display();
  }

  if (rotate) {
    rotZ += 0.01;
  }
  popMatrix();

  noLights();
  fill(255);
  text("\nr to enable spin\nmouse drag to rotate view", 10, 30);
}

void keyPressed() {
  if (key == 'r') {
    rotate = !rotate;
  }
}

void mouseDragged() {
  rotX += (mouseX - pmouseX) * 0.01;
  rotY -= (mouseY - pmouseY) * 0.01;
}

