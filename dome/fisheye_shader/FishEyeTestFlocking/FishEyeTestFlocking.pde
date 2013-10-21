/**
 * Fish Eye
 * 
 * This fish-eye shader is useful for dome projection.
 */

PShader fisheye;
PGraphics canvas;
PImage img;

boolean useFishEye = true;
boolean showGrid = true;

Flock flock;

void setup() {
  size(displayHeight, displayHeight, P2D);  
  canvas = createGraphics(width, height, P2D);

  flock = new Flock();
  // Add an initial set of boids into the system
  for (int i = 0; i < 500; i++) {
    flock.addBoid(new Boid(width/2, height/2));
  }

  fisheye = loadShader("FishEye.glsl");
  fisheye.set("aperture", 180.0);
}

void draw() {
  canvas.beginDraw();
  canvas.background(0);

  if (showGrid) {
    canvas.stroke(150);
    for (int i = 0; i < width; i += 20) {
      canvas.line(i, 0, i, height);
    }
    for (int i = 0; i < height; i += 20) {
      canvas.line(0, i, width, i);
    }
  }

  flock.run();


  canvas.fill(255);
  canvas.textAlign(CENTER);
  canvas.text("f to toggle fisheye\ng to toggle grid", height/2, height/2);

  canvas.endDraw(); 


  if (useFishEye == true) {
    shader(fisheye);
  } 
  image(canvas, 0, 0, width, height);
}

void keyPressed() {
  if (key == 'f') {
    useFishEye = !useFishEye;
      if (!useFishEye) {
      resetShader();
    }
  } 
  if (key == 'g') {
    showGrid = !showGrid;
  }
}

