// Earth model with bump mapping, specular texture and dynamic cloud layer.
// Adpated from the THREE.js tutorial:
// http://learningthreejs.com/blog/2013/09/16/how-to-make-the-earth-in-webgl/

// Example courtesy of Andres Colubri
// Compatible with Processing 2.1+ only

PShape earth;
PShape clouds;
PImage earthTex;
PImage cloudTex;
PImage alphaTex;
PImage bumpMap;
PImage specMap;
PShader earthShader;
PShader cloudShader;

float earthRotation;
float cloudsRotation;

void setup() {  
  size(600, 600, P3D);

  earthTex = loadImage("earthmap1k.jpg");
  cloudTex = loadImage("earthcloudmap.jpg");
  alphaTex = loadImage("earthcloudmaptrans.jpg");
  
  bumpMap = loadImage("earthbump1k.jpg");
  specMap = loadImage("earthspec1k.jpg");

  earthShader = loadShader("EarthFrag.glsl", "EarthVert.glsl");
  earthShader.set("texMap", earthTex);
  earthShader.set("bumpMap", bumpMap);
  earthShader.set("specularMap", specMap);
  earthShader.set("bumpScale", 0.05);
  
  cloudShader = loadShader("CloudFrag.glsl", "CloudVert.glsl");
  cloudShader.set("texMap", cloudTex);
  cloudShader.set("alphaMap", alphaTex);
  
  earth = createShape(SPHERE, 200, 32, 32);
  earth.setStroke(false);
  earth.setSpecular(color(125));
  earth.setShininess(10);
  
  clouds = createShape(SPHERE, 201, 32, 32);
  clouds.setStroke(false);  
}

void draw() {
  background(0);
  
  translate(width/2, height/2);
  
  pointLight(255, 255, 255, 300, 0, 500);  
  
  float targetAngle = map(mouseX, 0, width, 0, TWO_PI);  
  earthRotation += 0.05 * (targetAngle - earthRotation);
  
  shader(earthShader);
  pushMatrix();
  rotateY(earthRotation);
  shape(earth);
  popMatrix();
  
  shader(cloudShader);
  pushMatrix();
  rotateY(earthRotation + cloudsRotation);
  shape(clouds);
  popMatrix();
  
  cloudsRotation += 0.001;
}
