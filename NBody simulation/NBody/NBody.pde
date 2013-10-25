// NOC Cosmos
// NBody Simulation
// https://github.com/shiffman/The-Nature-of-Code-Cosmos-Edition

// Adapted from http://physics.princeton.edu/~fpretori/Nbody/
// This one is slow computationally and we can only do about ~800 particles
Body bodies[]= new Body[800];

// A scaling factor for pixels
int scale = 600;

// This example is using more accurate physics than usual so everything is double
double G = 6.673e-11;   // Gravitational constant
double solarmass=1.98892e30;

void setup() {
  size(640, 480, P2D);
  begin();
}

void draw() {
  background(0);
  fill(255);
  text(int(frameRate), 10, 30);

  translate(width/2, height/2); 

  for (int i = 0; i < bodies.length; i++) {
    bodies[i].display();
    bodies[i].resetForce();
    for (int j = 0; j < bodies.length; j++) {
      if (i != j) bodies[i].addForce(bodies[j]);
    }
  }
  // Loop again and update the bodies using timestep dt
  for (int i = 0; i < bodies.length; i++) {
    bodies[i].update(1e11);
  }
}

// Initialize N bodies with random positions and circular velocities
void begin() {
  double radius = 1e18;        // Radius of universe
  double solarmass=1.98892e30;
  for (int i = 0; i < bodies.length; i++) {
    double px = 1e18*exp(-1.8)*(.5-Math.random());
    double py = 1e18*exp(-1.8)*(.5-Math.random());
    double magv = circlev(px, py);

    double absangle = Math.atan(Math.abs(py/px));
    double thetav= Math.PI/2-absangle;
    double phiv = Math.random()*Math.PI;
    double vx   = -1*Math.signum(py)*Math.cos(thetav)*magv;
    double vy   = Math.signum(px)*Math.sin(thetav)*magv;

    double mass = Math.random()*solarmass*10+1e20;
    bodies[i]   = new Body(px, py, vx, vy, mass);
  }

  // Put the central mass in
  bodies[0]= new Body(0, 0, 0, 0, 1e6*solarmass);
}

// The bodies are initialized in circular orbits around the central mass.
// This is just some physics to do that
double circlev(double rx, double ry) {
  double solarmass=1.98892e30;
  double r2=Math.sqrt(rx*rx+ry*ry);
  double numerator=(6.67e-11)*1e6*solarmass;
  return Math.sqrt(numerator/r2);
}

double exp(double lambda) {
  return -Math.log(1 - Math.random()) / lambda;
}


