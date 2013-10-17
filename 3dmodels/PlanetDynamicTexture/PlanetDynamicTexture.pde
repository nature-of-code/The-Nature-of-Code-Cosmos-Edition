

PImage texture;
PShape planet;

void setup() {
  size(640, 480, P3D);
  texture = createImage(512, 256, ARGB);
  noStroke();
  fill(255);
  planet = createShape(SPHERE, 200);
  planet.setTexture(texture);
}

void draw() {
  background(0);
  calcTexture();
  translate(width/2, height/2);
  lights();
  rotateY(frameCount*0.003);
  rotateX(frameCount*0.0024);
  shape(planet);
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

