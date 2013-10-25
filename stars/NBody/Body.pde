
 class Body {

   double rx, ry;       // holds the cartesian positions
   double vx, vy;       // velocity components 
   double fx, fy;       // force components
   double mass;         // mass

    // create and initialize a new Body
   Body(double rx, double ry, double vx, double vy, double mass) {
    this.rx    = rx;
    this.ry    = ry;
    this.vx    = vx;
    this.vy    = vy;
    this.mass  = mass;
  }

  void display() {

    stroke(255, 200);
    strokeWeight(2);
    point((int) Math.round(rx*scale/1e18), (int) Math.round(ry*scale/1e18));
  }

  // update the velocity and position using a timestep dt
   void update(double dt) {
    vx += dt * fx / mass;
    vy += dt * fy / mass;
    rx += dt * vx;
    ry += dt * vy;
  }

  // returns the distance between two bodies
   double distanceTo(Body b) {
    double dx = rx - b.rx;
    double dy = ry - b.ry;
    return Math.sqrt(dx*dx + dy*dy);
  }

  // set the force to 0 for the next iteration
   void resetForce() {
    fx = 0.0;
    fy = 0.0;
  }

  // compute the net force acting between the body a and b, and
  // add to the net force acting on a
   void addForce(Body b) {
    Body a = this;
    double EPS = 3E4;      // softening parameter (just to avoid infinities)
    double dx = b.rx - a.rx;
    double dy = b.ry - a.ry;
    double dist = Math.sqrt(dx*dx + dy*dy);
    double F = (G * a.mass * b.mass) / (dist*dist + EPS*EPS);
    a.fx += F * dx / dist;
    a.fy += F * dy / dist;
  }

  // convert to string representation formatted nicely
   String toString() {
    return "" + rx + ", "+ ry+ ", "+  vx+ ", "+ vy+ ", "+ mass;
  }
}

