PShape shuttle;

float rotX, rotY;

void setup() {
  size(600, 400, P3D);
  shuttle = loadShape("shuttle.obj");
  shuttle.scale(100);
}

void draw() {
  background(127);
  translate(width/2, height/2);
  rotateX(rotY);
  rotateY(rotX);
  lights();
  shape(shuttle);
}

void mouseDragged() {
  rotX += (mouseX - pmouseX) * 0.01;
  rotY -= (mouseY - pmouseY) * 0.01;
}

