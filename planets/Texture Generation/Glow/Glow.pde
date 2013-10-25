

void setup() {
  size(800, 800);
}

void draw() {

  background(0);

  stroke(255);
  noFill();
  strokeWeight(64);
  ellipse(400, 400, 800-128, 800-128);
  filter(BLUR, 16);

  PImage img = createImage(width, height, ARGB);
  loadPixels();
  img.loadPixels();
  for (int i = 0; i < pixels.length; i++) {
    float b = brightness(pixels[i]);
    img.pixels[i] = color(255,b);
  } 
  img.updatePixels();
  img.save("glow.png");

  noLoop();
}

