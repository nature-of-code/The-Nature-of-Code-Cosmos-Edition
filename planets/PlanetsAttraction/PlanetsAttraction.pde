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

PImage[] textures = new PImage[5];

Starfield stars;

float rotX, rotY;


void setup() {
  size(800, 800, P3D);

  textures[0] = loadImage("blue.png");
  textures[1] = loadImage("moon.jpg");
  textures[2] = loadImage("earth.jpg");
  textures[3] = loadImage("mars.jpg");
  textures[4] = loadImage("jupiter.jpg");

  
  // Some random planets
  for (int i = 0; i < planets.length; i++) {
    int index = int(random(textures.length));
    planets[i] = new Planet(textures[index]);
  }
  // A single sun
  PImage suntex = loadImage("sun.png");  
  s = new Sun(suntex);
  
  stars = new Starfield();
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

  rotateX(rotY);
  rotateY(rotX);
  
  stars.display();

  // Display the Sun
  s.display();

  // All the Planets
  for (int i = 0; i < planets.length; i++) {
    planets[i].display();
  }

}


void mouseDragged() {
  rotX += (mouseX - pmouseX) * 0.01;
  rotY -= (mouseY - pmouseY) * 0.01;
}

