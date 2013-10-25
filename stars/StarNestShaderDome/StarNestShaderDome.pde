/**
 * Star Nest
 * https://www.shadertoy.com/view/4dfGDM by kali
 */

import codeanticode.planetarium.*;

DomeCamera camera;

PShader shader;
boolean dome = true;

void setup() {
  size(640, 360, Dome.RENDERER);
  camera = new DomeCamera(this);

  noStroke();

  // The code of this shader shows how to integrate shaders from shadertoy
  // into Processing with minimal changes.
  shader = loadShader("stars.glsl");
  shader.set("resolution", float(width), float(height));
}

void pre() {
  shader.set("time", (float)(millis()/1000.0));
}

void draw() {
  background(0);

  shader(shader); 
  rect(0, 0, width, height);

  //frame.setTitle("frame: " + frameCount + " - fps: " + frameRate);
}

void keyPressed() {
  if (key == ' ') {
    dome = !dome;
    if (dome) camera.enable();
    else camera.disable();
  }
}

