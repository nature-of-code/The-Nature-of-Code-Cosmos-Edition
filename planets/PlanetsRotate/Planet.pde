// NOC Cosmos
// https://github.com/shiffman/The-Nature-of-Code-Cosmos-Edition

// Planets, adapted from Processing example by Andres Colubri

class Planet {
  
  // A shape and a texture
  PShape shape;
  PImage texture;
  
  // A position and rotation on 3 axes
  PVector pos;
  PVector rot;
 
  // How big
  float radius;
  
  // What planets are orbiting
  ArrayList<Planet> orbits;
  
  // Light source?  Ring?
  boolean light = false;
  boolean ring = false;
  
  // Bunch of angles for spinning and orbiting
  PVector spinAngles;
  PVector orbitAngles;
  PVector spinSpeed;
  PVector orbitSpeed;

  Planet(PImage t, float r) {
    // Create the planet
    orbits = new ArrayList<Planet>();
    pos = new PVector();
    texture = t;
    radius = r;
    noStroke();
    sphereDetail(40);
    shape = createShape(SPHERE, r);
    shape.setTexture(texture);

    spinAngles = new PVector();
    orbitAngles = new PVector();
    spinSpeed = new PVector();
    orbitSpeed = new PVector();
  }
  
  // Add an orbit with an offset
  void addOrbit(Planet p, float x, float y, float z) {
    p.setPosition(x, y, z);
    orbits.add(p);
  }
  
  // Set the position
  void setPosition(float x, float y, float z) {
    pos.x = x;
    pos.y = y;
    pos.z = z;
  }
  
  // Set how fast it orbits
  void setOrbit(float x, float y, float z) {
    orbitSpeed.x = x;
    orbitSpeed.y = y;
    orbitSpeed.z = z;
  }
  // Set how fast it spins
  void setSpin(float x, float y, float z) {
    spinSpeed.x = x;
    spinSpeed.y = y;
    spinSpeed.z = z;
  }
  
  // Update and rotate orbits
  void orbit() {
    orbitAngles.add(orbitSpeed);
    rotateX(orbitAngles.x);
    rotateY(orbitAngles.y);
    rotateZ(orbitAngles.z);
  }
  
  // Update spin angles
  void spin() {
    spinAngles.add(spinSpeed);
  }
  
  // Draw
  void display() {
    pushMatrix();
    // Location
    translate(pos.x, pos.y, pos.z);
    pushMatrix();
    // Spinning
    rotateX(spinAngles.x);
    rotateY(spinAngles.y);
    rotateZ(spinAngles.z);
    shape(shape);
    // A ring (have to unrotate, boy this is getting silly)
    if (ring) {
      rotateZ(-spinAngles.z);
      rotateY(-spinAngles.y);
      rotateX(-spinAngles.x);
      rotateZ(-orbitAngles.z);
      rotateY(-orbitAngles.y);
      rotateX(-orbitAngles.x);
      rotateX(PI/2);
      imageMode(CENTER);
      image(ringImg, 0, 0, radius*5, radius*5);
      // Or just a circle
      //strokeWeight(4);
      //stroke(255,200);
      //noFill();
      //ellipse(0, 0, radius*4, radius*4);
    }
    popMatrix();
   
    // A light
    if (light) {
      pointLight(255, 255, 255, 0, 0, 0);
    }
 
    // Any nested planets
    for (Planet p : orbits) {
      pushMatrix();
      p.orbit();
      p.display();
      popMatrix();
    }
    popMatrix();
  }
}

