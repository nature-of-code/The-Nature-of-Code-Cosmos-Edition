// Planets, adapted from Processing example by Andres Colubri
//
// Sun and mercury textures from http://planetpixelemporium.com
// Star field picture from http://www.galacticimages.com/

PImage starfield;
PImage ringImg;

Planet sun;

Planet earth;
Planet mercury;
Planet moon;

void setup() {
  size(1200, 768, P3D);

  starfield = loadImage("starfield.jpg");
  PImage suntex = loadImage("sun.png");  
  PImage surftex1 = loadImage("earth.jpg");  
  PImage surftex2 = loadImage("mercury.jpg"); 
  PImage moontex = loadImage("moon.jpg"); 
  ringImg = loadImage("glow.png");
  
  sun = new Planet(suntex, 150);
  sun.setPosition(width/2, height/2, -300);
  sun.light = true;

  earth = new Planet(surftex1, 150);
  
  mercury = new Planet(surftex2, 50);
  sun.addOrbit(earth, 800, 0, 0);
  sun.addOrbit(mercury, 400, 0, 0);
  earth.setOrbit(0, 0.004, 0);
  mercury.setOrbit(0.003, 0.007, 0);
  mercury.ring = true;
  
  
  moon = new Planet(moontex,25);
  
  earth.addOrbit(moon,0,200,0);
  moon.setOrbit(0,0.002,0.0123);
  
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

  sun.display();
  
  earth.spin();
}

