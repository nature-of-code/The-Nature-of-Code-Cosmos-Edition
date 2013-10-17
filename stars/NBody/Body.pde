import java.awt.Color;

public class Body {
  private static final double G = 6.673e-11;   // gravitational constant
  private static final double solarmass=1.98892e30;

  public double rx, ry;       // holds the cartesian positions
  public double vx, vy;       // velocity components 
  public double fx, fy;       // force components
  public double mass;         // mass
  //public Color color;         // color (for fun)
  color c;
  // create and initialize a new Body
  public Body(double rx, double ry, double vx, double vy, double mass, color c) {
    this.rx    = rx;
    this.ry    = ry;
    this.vx    = vx;
    this.vy    = vy;
    this.mass  = mass;
    this.c = c;
  }

  // update the velocity and position using a timestep dt
  public void update(double dt) {
    vx += dt * fx / mass;
    vy += dt * fy / mass;
    rx += dt * vx;
    ry += dt * vy;
  }

  // returns the distance between two bodies
  public double distanceTo(Body b) {
    double dx = rx - b.rx;
    double dy = ry - b.ry;
    return Math.sqrt(dx*dx + dy*dy);
  }

  // set the force to 0 for the next iteration
  public void resetForce() {
    fx = 0.0;
    fy = 0.0;
  }

  // compute the net force acting between the body a and b, and
  // add to the net force acting on a
  public void addForce(Body b) {
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
  public String toString() {
    return "" + rx + ", "+ ry+ ", "+  vx+ ", "+ vy+ ", "+ mass;
  }

  public boolean in(Quad q) {
    return q.contains(this.rx, this.ry);
  }
}
}
