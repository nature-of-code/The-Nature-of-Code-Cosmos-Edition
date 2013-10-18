

PImage texture;
PShape planet;

ParticleSystem ps;
PImage sprite;  


void setup() {
  size(640, 480, P3D);
  texture = createImage(512, 256, ARGB);
  noStroke();
  fill(255);
  planet = createShape(SPHERE, 100);
  planet.setTexture(texture);

  sprite = loadImage("sprite.png");
  ps = new ParticleSystem(2000);

}

void draw() {
  background(0);
  calcTexture();


  pushMatrix();
  translate(width/2, height/2);
  hint(DISABLE_DEPTH_MASK);
  ps.update();
  ps.display();
  hint(ENABLE_DEPTH_MASK);

  lights();
  rotateY(frameCount*0.003);
  rotateX(frameCount*0.0024);
  shape(planet);

  rotateX(-frameCount*0.0024);
  rotateY(-frameCount*0.003);
  noFill();
  for (int i = 0; i < 10; i++) {
    stroke(255, 255, 0, 127-i*20);
    strokeWeight(5);
    ellipse(0, 0, 200+i*5, 200+i*5);
  }

  fill(255);
  textSize(16);
  popMatrix();
  text("Frame rate: " + int(frameRate), 10, 20);
}

float zoff = 0;
void calcTexture() {
  texture.loadPixels();
  float xoff = 0.0; // Start xoff at 0
  for (int x = 0; x < texture.width; x++) {
    xoff += 0.05;   // Increment xoff 
    float yoff = 0.0;   // For every xoff, start yoff at 0
    for (int y = 0; y < texture.height; y++) {
      yoff += 0.05; // Increment yoff
      float bright = noise(xoff, yoff, zoff) * 255;
      // Set each pixel onscreen to a grayscale value
      texture.pixels[x+y*texture.width] = color(255, bright, 0);
    }
  }
  zoff += 0.005;
  texture.updatePixels();
}

