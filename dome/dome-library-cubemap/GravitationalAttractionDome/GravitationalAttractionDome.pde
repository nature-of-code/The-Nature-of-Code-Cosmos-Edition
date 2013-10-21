  /**
 * Gravitational Attraction (3D) 
 * by Daniel Shiffman.  
 *
 * Adapted for dome projection by Andres Colubri
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

import codeanticode.planetarium.*;

// A bunch of planets
Planet[] planets = new Planet[10];
// One sun (note sun is not attracted to planets (violation of Newton's 3rd Law)
Sun s;

// An angle to rotate around the scene
float angle = 0;

void setup() {
  size(800, 800, Dome.RENDERER);
  smooth();
  // Some random planets
  for (int i = 0; i < planets.length; i++) {
    planets[i] = new Planet(random(0.1, 2), random(-width/2, width/2), random(-height/2, height/2), random(-100, 100));
  }
  // A single sun
  s = new Sun();
}

void pre() {
  for (int i = 0; i < planets.length; i++) {
    // Sun attracts Planets
    PVector force = s.attract(planets[i]);
    planets[i].applyForce(force);
    // Update and draw Planets
    planets[i].update();
  }  
}

void draw() {
  background(0);  
  
  // Setup the scene
  lights();
  
  translate(width/2, height/2, 300);
  
  rotateY(angle);

  // Display the Sun
  s.display();

  // All the Planets
  for (int i = 0; i < planets.length; i++) {
    planets[i].display();
  }
}

// Called after rendering all the faces, but before the dome sphere,
// so it can be used to draw stuff on the corners of the screen.
void border() {
  perspective();
  camera();
  background(255);
  fill(0);
  text("FPS: " + frameRate, 20, 20);
}  

void post() {
  // Rotate around the scene
  angle += 0.003;
}  