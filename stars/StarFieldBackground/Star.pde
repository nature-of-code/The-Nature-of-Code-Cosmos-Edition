class Star {
  PVector pos;
  
  float r;

  Star() {
    pos = PVector.random3D();
    pos.mult(depth);
    r = 2;
  }

  void display() {
    stroke(255, 127);
    strokeWeight(r);
    point(pos.x, pos.y, pos.z);
    
    
  }
}

