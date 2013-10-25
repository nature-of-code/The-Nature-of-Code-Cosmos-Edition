// NOC Cosmos
// NBody Simulation
// https://github.com/shiffman/The-Nature-of-Code-Cosmos-Edition

// Adapted from http://physics.princeton.edu/~fpretori/Nbody/

class Body {

  double rx, ry;       // holds the cartesian positions
  double vx, vy;       // velocity components 
  double fx, fy;       // force components
  double mass;         // mass

  // Create and initialize a new Body
  Body(double rx, double ry, double vx, double vy, double mass) {
    this.rx    = rx;
    this.ry    = ry;
    this.vx    = vx;
    this.vy    = vy;
    this.mass  = mass;
  }
  
  // Draw body
  void display() {
    stroke(255, 200);
    strokeWeight(2);
    // Got to go back to float
    point((float)rx*scale/1e18, (float)ry*scale/1e18);
  }

  // Update the velocity and position using a timestep dt
  void update(double dt) {
    vx += dt * fx / mass;
    vy += dt * fy / mass;
    rx += dt * vx;
    ry += dt * vy;
  }

  // Returns the distance between two bodies
  double distanceTo(Body b) {
    double dx = rx - b.rx;
    double dy = ry - b.ry;
    return Math.sqrt(dx*dx + dy*dy);
  }

  // Set the force to 0 for the next iteration
  void resetForce() {
    fx = 0.0;
    fy = 0.0;
  }

  // Compute the net force acting between the body a and b, and
  // Add to the net force acting on a
  void addForce(Body b) {
    Body a = this;
    double EPS = 3E4;      // Softening parameter (just to avoid infinities)
    double dx = b.rx - a.rx;
    double dy = b.ry - a.ry;
    double dist = Math.sqrt(dx*dx + dy*dy);
    double F = (G * a.mass * b.mass) / (dist*dist + EPS*EPS);
    a.fx += F * dx / dist;
    a.fy += F * dy / dist;
  }

}

