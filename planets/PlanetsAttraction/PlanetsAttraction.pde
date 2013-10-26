// NOC Cosmos
// https://github.com/shiffman/The-Nature-of-Code-Cosmos-Edition

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

// Some textures
PImage[] textures = new PImage[5];
import codeanticode.planetarium.*;

// A background starfield
Starfield stars;

DomeCamera camera;

float cubeX, cubeY;
float domeZ = 0;
float domeScale = 1;
boolean dome = true;
boolean grid = false;


// Lame not-arcball rotation
float rotX, rotY;


void setup() {
  size(800, 800, Dome.RENDERER);

  // Load textures
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

  camera = new DomeCamera(this);
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

  translate(width/2, height/2, 300);

  rotateX(rotY);
  rotateY(rotX);

  // Draw background
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

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      domeZ += 1;
      println("Dome Z    : " + domeZ);
      camera.translate(0, 0, domeZ);
    } 
    else if (keyCode == DOWN) {
      domeZ -= 1;
      println("Dome Z    : " + domeZ);
      camera.translate(0, 0, domeZ);
    } 
    else if (keyCode == LEFT) {
      domeScale -= 0.05;
      println("Dome scale: " + domeScale);
      camera.scale(domeScale);
    } 
    else if (keyCode == RIGHT) {
      domeScale += 0.05;
      println("Dome scale: " + domeScale);
      camera.scale(domeScale);
    }
  } 
  else {
    if (key == 'g') {
      grid = !grid;
      println(grid);
      if (grid) camera.setMode(Dome.GRID);
      else camera.setMode(Dome.NORMAL);
    } 
    else if (key == ' ') {
      dome = !dome;
      if (dome) camera.enable();
      else camera.disable();
    }
  }
}

