// NOC Cosmos
// https://github.com/shiffman/The-Nature-of-Code-Cosmos-Edition

// Simple star!

class Star {
  PVector pos;
  // Size
  float r;

  Star() {
    // Magic a random 3D vector is a point on a sphere of radius 1
    pos = PVector.random3D();
    // Expand by size of sphere
    pos.mult(depth);
    r = 2;
  }

  // Just a sad little point
  void display() {
    stroke(255, 127);
    strokeWeight(r);
    point(pos.x, pos.y, pos.z);
  }
}

