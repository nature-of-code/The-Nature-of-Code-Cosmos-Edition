

PImage noise;
PImage texture;
PShape planet;

void setup() {
  size(640, 480, P3D);
  noise = createImage(512, 256, ARGB);
  texture = createImage(512, 256, ARGB);
  noStroke();
  fill(255);
  planet = createShape(SPHERE, 150);
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
  noise.loadPixels();
  float xoff = 0.0; // Start xoff at 0
  
  // Half
  for (int x = 0; x < texture.width/2; x++) {
    xoff += 0.05;   // Increment xoff 
    float yoff = 0.0;   // For every xoff, start yoff at 0
    for (int y = 0; y < texture.height; y++) {
      yoff += 0.05; // Increment yoff
      float bright = noise(xoff, yoff, zoff) * 255;
      // Set each pixel onscreen to a grayscale value
      noise.pixels[x+y*noise.width] = color(255, bright, 0);
    }
  }
  
  // Another half in reverse so it tiles perfectly
  for (int x = texture.width/2; x < texture.width; x++) {
    xoff -= 0.05;   // Increment xoff 
    float yoff = 0.0;   // For every xoff, start yoff at 0
    for (int y = 0; y < texture.height; y++) {
      yoff += 0.05; // Increment yoff
      float bright = noise(xoff, yoff, zoff) * 255;
      // Set each pixel onscreen to a grayscale value
      noise.pixels[x+y*noise.width] = color(255, bright, 0);
    }
  }



  zoff += 0.02;
  noise.updatePixels();
  sphericalTexture(noise, texture, 512, 256);
}

void sphericalTexture(PImage source, PImage dest, int w, int h) {
  dest.loadPixels();
  for (int x = 0; x < w; x++) {
    for (int y = 0; y < h; y++) {
      // The angle values corresponding to each x,y pair:
      float phi = map(x, 0, w, -PI, PI); 
      float theta = map(y, 0, h, -HALF_PI, HALF_PI);

      float phi2 = phi * cos(theta);
      int newx = int(map(phi2, 0, TWO_PI, 0, source.width));

      dest.pixels[x + y * w] = source.pixels[newx + y * source.width];
    }
  }
  dest.updatePixels();
}

