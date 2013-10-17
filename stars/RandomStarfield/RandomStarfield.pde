Star[] stars = new Star[1000];

float factor = 1;
float target = 1;

float depth = 5000;

boolean hyperdrive = false;
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
  factor = lerp(factor, target, 0.1);
  
  pushMatrix();
  translate(width/2, height/2);
  rotateX(rotY);
  rotateY(rotX);
  rotateZ(rotZ);

  for (Star s : stars) {
    s.update();
    s.display();
  }

  if (rotate) {
    rotZ += 0.01;
  }
  popMatrix();
  
  fill(255);
  text("space to engage hyperdrive\nr to enable spin\nmouse drag to rotate view",10,30);
}

void keyPressed() {
  if (key == ' ') {
    hyperdrive = !hyperdrive;
    if (hyperdrive) {
      target = 50;
    } 
    else {
      target = 1;
    }
  } 
  else if (key == 'r') {
    rotate = !rotate;
  }
}

void mouseDragged() {
  rotX += (mouseX - pmouseX) * 0.01;
  rotY -= (mouseY - pmouseY) * 0.01;
}

