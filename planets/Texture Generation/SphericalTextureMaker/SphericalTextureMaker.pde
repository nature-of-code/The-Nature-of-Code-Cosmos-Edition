// Thank you Paul Bourke!
// http://paulbourke.net/texture_colour/tiling/

PImage noise;
PImage marble;
PImage texture1;
PImage texture2;

void setup() {
  size(1024, 512);
  marble = loadImage("marble.jpg");
  noise = createImage(512, 256, ARGB);
  noise.loadPixels();
  for (int i = 0; i < noise.pixels.length; i++) {
    noise.pixels[i] = color(random(255));
  }
  noise.updatePixels();
  texture1 = sphericalTexture(noise, 512, 256);
  texture2 = sphericalTexture(marble, 512, 256);
}

void draw() {
  background(0);
  image(noise, 0, 0);
  image(texture1, 0, 256);
  image(marble, 512, 0);
  image(texture2, 512, 256);


}

PImage sphericalTexture(PImage source,int w, int h) {
  PImage texture = createImage(w,h,ARGB);
  texture.loadPixels();
  for (int x = 0; x < w; x++) {
    for (int y = 0; y < h; y++) {
      // The angle values corresponding to each x,y pair:
      float phi = map(x, 0, w, -PI, PI); 
      float theta = map(y, 0, h, -HALF_PI, HALF_PI);

      float phi2 = phi * cos(theta);
      int newx = int(map(phi2, 0, TWO_PI, 0, source.width));

      texture.pixels[x + y * w] = source.pixels[newx + y * source.width];
    }
  }
  texture.updatePixels();
  return texture;
}

