// NOC Cosmos
// https://github.com/shiffman/The-Nature-of-Code-Cosmos-Edition

// From http://paulbourke.net/texture_colour/perlin/

// Texture and sphere
PImage texture;
PShape planet;

void setup() {
  size(640, 480, P3D);
  // Make everything
  texture = createImage(512, 256, ARGB);
  noStroke();
  fill(255);
  calcTexture();
  planet = createShape(SPHERE, 200);
  planet.setTexture(texture);
}

void draw() {
  background(0);
  // Draw textured planet
  translate(width/2, height/2);
  lights();
  rotateY(frameCount*0.003);
  rotateX(frameCount*0.0024);
  shape(planet);
}

// Algorithm for texture 
// From http://paulbourke.net/texture_colour/perlin/
void calcTexture() {
  texture.loadPixels();
  Perlin perlin = new Perlin();
  for (int j = 0; j < texture.height; j++) {
    for (int i = 0; i < texture.width; i++) {
      // The angle values corresponding to each u,v pair:
      float u = float(i) / texture.width;
      float v = float(j) / texture.height;
      float phi = map(u, 0, 1, TWO_PI, 0); 
      float theta = map(v, 0, 1, -HALF_PI, HALF_PI);
      // The x, y, z point corresponding to these angles:
      float x = cos(phi) * cos(theta);
      float y = sin(theta);            
      float z = sin(phi) * cos(theta);      
      float n = perlin.noise3D(x, y, z, 1.2, 2, 8);
      // We could be more clever about how we pick colors
      float r = 255;
      float g = map(n, -0.7, 0.7, 255, 0);
      float b = 0;
      texture.pixels[j * texture.width + i] = color(r, g, b);
    }
  } 
  texture.updatePixels();
}

