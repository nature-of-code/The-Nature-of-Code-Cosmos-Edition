class Star {
  PVector pos;
  PVector originalVel;
  PVector vel;

  Star() {
    pos = new PVector(random(-5*width, 5*width), random(-5*height, 5*height), random(-depth, depth));
    originalVel = new PVector(0, 0, random(1, 5));
    vel = originalVel.get();
  }

  void display() {
    stroke(255, 127);
    strokeWeight(1.5);
    point(pos.x, pos.y, pos.z);
    beginShape();
    for (int i = 0; i < 5; i++) {
      vertex(pos.x-vel.x*i, pos.y-vel.y*i, pos.z-vel.z*i);
    }
    endShape();
  }

  void update() {
    vel.z = originalVel.z*factor;  
    pos.add(vel);
    if (pos.z > depth)
      pos.z = -depth;
  }
}

