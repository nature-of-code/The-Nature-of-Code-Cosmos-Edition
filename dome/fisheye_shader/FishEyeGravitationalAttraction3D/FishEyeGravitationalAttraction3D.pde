/**
 * Gravitational Attraction (3D) 
 * by Daniel Shiffman.  
 * 
 * Simulating gravitational attraction 
 * G ---> universal gravitational constant
 * m1 --> mass of object #1
 * m2 --> mass of object #2
 * d ---> distance between objects
 * F = (G*m1*m2)/(d*d)
 *
 * For the basics of working with PVector, see
 * http://processing.org/learning/pvector/
 * as well as examples in Topics/Vectors/
 * 
 */

PShader fisheye;
PGraphics canvas;

boolean useFishEye = true;
boolean showGrid = true;

// A bunch of planets
Planet[] planets = new Planet[10];
// One sun (note sun is not attracted to planets (violation of Newton's 3rd Law)
Sun s;

// An angle to rotate around the scene
float angle = 0;

void setup() {
  size(displayHeight, displayHeight, P3D);  
  canvas = createGraphics(width, height, P3D);

  // Some random planets
  for (int i = 0; i < planets.length; i++) {
    planets[i] = new Planet(random(0.1, 2), random(-width/2, width/2), random(-height/2, height/2), random(-100, 100));
  }
  // A single sun
  s = new Sun();

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

  // Setup the scene
  canvas.sphereDetail(8);
  canvas.lights();
  canvas.translate(width/2, height/2);
  canvas.rotateY(angle);




  // Display the Sun
  s.display();

  // All the Planets
  for (int i = 0; i < planets.length; i++) {
    // Sun attracts Planets
    PVector force = s.attract(planets[i]);
    planets[i].applyForce(force);
    // Update and draw Planets
    planets[i].update();
    planets[i].display();
  }

  canvas.fill(255);
  canvas.textAlign(CENTER);
  canvas.text("f to toggle fisheye\ng to toggle grid", 0,0);

  canvas.endDraw(); 

  if (useFishEye == true) {
    shader(fisheye);
  } 
  image(canvas, 0, 0, width, height);
  
  // Rotate around the scene
  angle += 0.003;
  
  
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




