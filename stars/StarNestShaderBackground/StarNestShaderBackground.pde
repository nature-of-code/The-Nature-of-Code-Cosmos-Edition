// NOC Cosmos
// https://github.com/shiffman/The-Nature-of-Code-Cosmos-Edition

// Shader needs to be tiled and spherized
// https://github.com/shiffman/The-Nature-of-Code-Cosmos-Edition/issues/8

/**
 * Star Nest
 * https://www.shadertoy.com/view/4dfGDM by kali
 */


PShader shader;

PGraphics canvas;

PShape sphere;

boolean rotate = false;

float rotX, rotY, rotZ;

void setup() {
  size(800, 800, P3D);
  canvas = createGraphics(512, 256, P3D);

  // The code of this shader shows how to integrate shaders from shadertoy
  // into Processing with minimal changes.
  shader = loadShader("stars.glsl");
  shader.set("resolution", float(canvas.width), float(canvas.height));

  noStroke();

  // Make larger sphere for it to be background
  // sphere = createShape(SPHERE, 800);

  sphere = createShape(SPHERE, 2400);

  sphere.setTexture(canvas);
}


void draw() {
  background(0);

  shader.set("time", (float)(millis()/1000.0));

  canvas.beginDraw();
  canvas.shader(shader); 
  canvas.rect(0, 0, canvas.width, canvas.height);
  canvas.endDraw();

  //image(canvas,0,0);
  pushMatrix();
  translate(width/2, height/2,0);
  rotateX(rotY);
  rotateY(rotX);
  rotateZ(rotZ);
  shape(sphere);

  lights();
  noStroke();
  fill(100);
  sphere(40);

  popMatrix();


  if (rotate) {
    rotZ += 0.01;
  }

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

