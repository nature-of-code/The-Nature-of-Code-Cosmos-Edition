// NOC Cosmos
// https://github.com/shiffman/The-Nature-of-Code-Cosmos-Edition

// Textures from: http://planetpixelemporium.com/

// Show how to draw sphere with texture
// Add a billboarded glow
// And billboarde particles

// A bunch of possible textures
PImage[] textures = new PImage[6];
// Which texture
int currentTex = 2;
// Our planet PShape
PShape planet;

// A particle system
ParticleSystem ps;
// Image for particle
PImage sprite;  
// A "glow" atmosphere image
PImage glow;

// current state
boolean glowing = false;
boolean sphere = true;
boolean particles = false;
boolean particleTex = false;

// Very lame not arcball rotation
float rotX, rotY;

float r = 300;


void setup() {
  size(1600, 1600, P3D);
  noStroke();
  fill(255);
  // Create sphere and load all possible textures
  planet = createShape(SPHERE, r);
  textures[0] = loadImage("blue.png");
  textures[1] = loadImage("moon.jpg");
  textures[2] = loadImage("sun.png");
  textures[3] = loadImage("earth.jpg");
  textures[4] = loadImage("mars.jpg");
  textures[5] = loadImage("jupiter.jpg");
  // Start with a texxture
  planet.setTexture(textures[currentTex]);
  // Load other assets
  glow = loadImage("glow.png");
  sprite = loadImage("sprite.png");
  ps = new ParticleSystem(2500);
}

void draw() {
  background(0);


  pushMatrix();
  translate(width/2, height/2);

  
  lights();
  rotateY(rotX);
  rotateX(rotY);
  // Sphere
  if (sphere) {
    shape(planet);
  }
  
  // Particles
  if (particles) {
    if (particleTex) {
      hint(DISABLE_DEPTH_MASK);
    }
    ps.update();
    ps.display();
    if (particleTex) {
      hint(ENABLE_DEPTH_MASK);
    }
  }
  
  // Unrotate to billboard glow
  rotateX(-rotY);
  rotateY(-rotX);
  if (glowing) {
    imageMode(CENTER);
    tint(255);
    image(glow, 0, 0, r*2.5, r*2.5);
  }

  // Some info
  fill(255);
  textSize(16);
  popMatrix();
  text("Frame rate: " + int(frameRate) + "\n1 to toggle sphere\n2 to toggle glow\n3 to toggle particles\n4 to toggle planet texture\n5 to toggle particle texture", 10, 20);
}

void keyPressed() {
  if (key == '1') {
    sphere = !sphere;
  } 
  else if (key == '2') {
    glowing = !glowing;
  } 
  else if (key == '3') {
    particles = !particles;
  } 
  else if (key == '4') {
    currentTex = (currentTex+1)%textures.length;
    planet.setTexture(textures[currentTex]);
  } 
  else if (key == '5') {
    particleTex = !particleTex;
  }
}

void mouseDragged() {
  rotX += (mouseX - pmouseX) * 0.01;
  rotY -= (mouseY - pmouseY) * 0.01;
}

