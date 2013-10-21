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


// A bunch of planets
Planet[] planets = new Planet[10];
// One sun (note sun is not attracted to planets (violation of Newton's 3rd Law)
Sun s;

PImage[] textures = new PImage[3];



// An angle to rotate around the scene
float angle = 0;

void setup() {
  size(800, 800, P3D);

  textures[0] = loadImage("earth.jpg");
  textures[1] = loadImage("moon.jpg");
  textures[2] = loadImage("mercury.jpg");
  
  // Some random planets
  for (int i = 0; i < planets.length; i++) {
    int index = int(random(textures.length));
    planets[i] = new Planet(textures[index]);
  }
  // A single sun
  PImage suntex = loadImage("sun.png");  
  s = new Sun(suntex);
}

void draw() {
  background(0);  
  for (int i = 0; i < planets.length; i++) {
    // Sun attracts Planets
    PVector force = s.attract(planets[i]);
    planets[i].applyForce(force);
    // Update and draw Planets
    planets[i].update();
  }    

  translate(width/2, height/2, 300);

  rotateY(angle);

  // Display the Sun
  s.display();

  // All the Planets
  for (int i = 0; i < planets.length; i++) {
    planets[i].display();
  }

  angle += 0.003;
}

