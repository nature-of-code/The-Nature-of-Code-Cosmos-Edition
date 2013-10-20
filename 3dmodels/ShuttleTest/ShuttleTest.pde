PShape shuttle;

float rotX, rotY;

void setup() {
  size(600, 400, P3D);
  shuttle = loadShape("shuttle.obj");
  shuttle.scale(50,50,50);
}

void draw() {
  background(0);
  translate(width/2, height/2,-100);
  rotateX(rotY);
  rotateY(rotX);
  lights();
  shape(shuttle);
}

void mouseDragged() {
  rotX += (mouseX - pmouseX) * 0.01;
  rotY -= (mouseY - pmouseY) * 0.01;
}

