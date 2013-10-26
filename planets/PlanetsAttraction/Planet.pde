// Gravitational Attraction (3D) 
// Daniel Shiffman <http://www.shiffman.net>

// A class for an orbiting Planet

class Planet {
  
  // Basic physics model (location, velocity, acceleration, mass)
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  PShape sphere;

  Planet(PImage texture) {
    mass = random(0.5,3.5);
    location = PVector.random3D();
    location.mult(random(100,width/2));
    velocity = new PVector(0,0,2);   // Arbitrary starting velocity
    acceleration = new PVector();    
    noStroke();
    // Planet is a PShape sphere
    sphere = createShape(SPHERE, mass*8, 20);
    sphere.setTexture(texture);
  }
  
  // Newton's 2nd Law (F = M*A) applied
  void applyForce(PVector force) {
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }

  // Our motion algorithm (aka Euler Integration)
  void update() {
    velocity.add(acceleration); // Velocity changes according to acceleration
    location.add(velocity);     // Location changes according to velocity
    acceleration.mult(0);
  }

  // Draw the Planet
  void display() {
    pushMatrix();
    translate(location.x,location.y,location.z);
    shape(sphere);
    popMatrix();
  }
}
