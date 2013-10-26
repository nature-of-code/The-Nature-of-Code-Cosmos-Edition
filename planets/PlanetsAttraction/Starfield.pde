class Starfield {
  Star[] stars = new Star[1000];

  Starfield() {
    for (int i=0; i<stars.length; i++) {
      stars[i] = new Star();
    }
  }

  void display() {
    for (Star s : stars) {
      s.display();
    }
  }
}

class Star {
  PVector pos;
  float depth = 1000;

  Star() {
    pos = PVector.random3D();
    pos.mult(depth);
  }

  void display() {
    stroke(255, 127);
    strokeWeight(2.5);
    point(pos.x, pos.y, pos.z);
  }
}

