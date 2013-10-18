class Star {
  PVector pos;

  Star() {
    pos = PVector.random3D();
    pos.mult(depth);
  }

  void display() {
    stroke(255, 127);
    strokeWeight(1.5);
    point(pos.x, pos.y, pos.z);
  }
}

