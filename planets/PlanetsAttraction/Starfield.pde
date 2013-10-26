// NOC Cosmos
// https://github.com/shiffman/The-Nature-of-Code-Cosmos-Edition

class Starfield {
  // 1000 stars
  Star[] stars = new Star[1000];

  // Make them all
  Starfield() {
    for (int i=0; i<stars.length; i++) {
      stars[i] = new Star();
    }
  }
  // Draw them all
  void display() {
    for (Star s : stars) {
      s.display();
    }
  }
}

class Star {
  // Just a position
  PVector pos;
  float depth = 1000;

  Star() {
    // A random position on a sphere
    pos = PVector.random3D();
    pos.mult(depth);
  }

  void display() {
    // Just a point
    stroke(255, 127);
    strokeWeight(2.5);
    point(pos.x, pos.y, pos.z);
  }
}

