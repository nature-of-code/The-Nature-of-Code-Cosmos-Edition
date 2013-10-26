// NOC Cosmos
// https://github.com/shiffman/The-Nature-of-Code-Cosmos-Edition

// Simple simulation of flying star

class Star {
  PVector pos;
  PVector originalVel;
  PVector vel;

  Star() {
    pos = new PVector(random(-5*width, 5*width), random(-5*height, 5*height), random(-depth, depth));
    // Save its starting velocity
    originalVel = new PVector(0, 0, random(1, 5));
    vel = originalVel.get();
  }

  void display() {
    stroke(255, 127);
    strokeWeight(1.5);
    point(pos.x, pos.y, pos.z);
    // We draw a trail based on its velocity
    beginShape();
    for (int i = 0; i < 5; i++) {
      vertex(pos.x-vel.x*i, pos.y-vel.y*i, pos.z-vel.z*i);
    }
    endShape();
  }
  
  // Move!
  void update() {
    // Eh, we could do better
    // Accessing global speed "factor"
    vel.z = originalVel.z*factor;  
    pos.add(vel);
    // Recycle the star when it passes far away
    if (pos.z > depth)
      pos.z = -depth;
  }
}

