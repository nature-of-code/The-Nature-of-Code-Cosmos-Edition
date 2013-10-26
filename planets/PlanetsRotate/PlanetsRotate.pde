// NOC Cosmos
// https://github.com/shiffman/The-Nature-of-Code-Cosmos-Edition

// Planets, adapted from Processing example by Andres Colubri
//
// Textures from http://planetpixelemporium.com
// Star field picture from http://www.galacticimages.com/

// Background starfield
PImage starfield;
PImage ringImg;

// A bunch of planets
Planet sun;
Planet earth;
Planet mercury;
Planet moon;

void setup() {
  size(1200, 768, P3D);
  // Background
  starfield = loadImage("starfield.jpg");
  
  // Textures
  PImage suntex = loadImage("sun.png");  
  PImage surftex1 = loadImage("earth.jpg");  
  PImage surftex2 = loadImage("mercury.jpg"); 
  PImage moontex = loadImage("moon.jpg"); 
  
  // A ring
  ringImg = loadImage("glow.png");
  
  // Make the sun
  sun = new Planet(suntex, 150);
  sun.setPosition(width/2, height/2, -300);
  // Planet can be a light source
  sun.light = true;
  
  // The earth
  earth = new Planet(surftex1, 150);
  
  mercury = new Planet(surftex2, 50);
  
  // Planets can be nested as orbits in other planets
  // not physics, just rotation
  sun.addOrbit(earth, 800, 0, 0);
  sun.addOrbit(mercury, 400, 0, 0);
  earth.setOrbit(0, 0.004, 0);
  mercury.setOrbit(0.003, 0.007, 0);
  
  // Planet can have a ring
  mercury.ring = true;
  
  // Make a moon
  moon = new Planet(moontex,25);
  
  // Moon is nested in earth
  earth.addOrbit(moon,0,200,0);
  moon.setOrbit(0,0.002,0.0123);
  
  // Earth spins  
  earth.setSpin(0,0.01,0);
}

void draw() {
  background(0);
  //lights();
  // Disabling writing to the depth mask so the 
  // background image doesn't occludes any 3D object.
  hint(DISABLE_DEPTH_MASK);
  imageMode(CORNER);
  image(starfield, 0, 0, width, height);
  hint(ENABLE_DEPTH_MASK);

  // All the planets get called nested inside the sun
  sun.display();
  
  // This is probably silly but spinning the earth
  earth.spin();
}

