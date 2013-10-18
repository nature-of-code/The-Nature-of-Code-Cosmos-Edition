

PImage[] textures = new PImage[3];
int currentTex = 0;
PShape planet;

ParticleSystem ps;
PImage sprite;  
PImage glow;

boolean glowing = false;
boolean sphere = false;
boolean particles = false;


void setup() {
  size(640, 480, P3D);
  noStroke();
  fill(255);
  planet = createShape(SPHERE, 100);
  textures[0] = loadImage("blue.png");
  textures[1] = loadImage("moon.jpg");
  textures[2] = loadImage("sun.png");
  planet.setTexture(textures[currentTex]);
  glow = loadImage("glow.png");
  sprite = loadImage("sprite.png");
  ps = new ParticleSystem(1000);
}

void draw() {
  background(0);


  pushMatrix();
  translate(width/2, height/2);


  lights();
  rotateY(frameCount*0.003);
  rotateX(frameCount*0.0024);
  if (sphere) {
    shape(planet);
  }

  rotateX(-frameCount*0.0024);
  rotateY(-frameCount*0.003);
  if (glowing) {
    imageMode(CENTER);
    image(glow, 0, 0, 250, 250);
  }

  if (particles) {
    hint(DISABLE_DEPTH_MASK);
    ps.update();
    ps.display();
    hint(ENABLE_DEPTH_MASK);
  }

  fill(255);
  textSize(16);
  popMatrix();
  text("Frame rate: " + int(frameRate) + "\n1 to toggle sphere\n2 to toggle glow\n3 to toggle particles\n4 to toggle textures", 10, 20);
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
    println(currentTex);
    currentTex = (currentTex+1)%textures.length;
    println(currentTex);
    planet.setTexture(textures[currentTex]);
  }
}

