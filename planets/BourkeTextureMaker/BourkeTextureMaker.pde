

PImage texture;

void setup() {
  size(640, 480, P3D);
  texture = createImage(512, 256, ARGB);
  calcTexture();
}

void draw() {
  background(0);
  image(texture,0,0);
  texture.save("blue.png");
  noLoop();
}

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
      float r = map(n, -0.7, 0.7, 0, 255);
      float b = 255;
      float g = map(n, -0.7, 0.7, 0, 255);
      texture.pixels[j * texture.width + i] = color(r, g, b);
    }
  } 
  texture.updatePixels();
}

