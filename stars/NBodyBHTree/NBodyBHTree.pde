
// Adapting http://physics.princeton.edu/~fpretori/Nbody/

public Body bodies[]= new Body[2000];
Quad q = new Quad(0, 0, 2*1e18);

void setup()
{
  size(640, 480, P2D);
  startthebodies();
}


//Called by the applet initally. It can be executed again by calling repaint();
void draw() {
  background(0);
  fill(255);
  text(frameRate, 10, 30);

  translate(width/2, height/2); //Originally the origin is in the top right. Put it in its normal place
  for (int i=0; i<bodies.length; i++) {
    stroke(255);
    strokeWeight(2);
    point((int) Math.round(bodies[i].rx*600/1e18), (int) Math.round(bodies[i].ry*600/1e18));
  }
  addforces();
}

//the bodies are initialized in circular orbits around the central mass.
//This is just some physics to do that
public static double circlev(double rx, double ry) {
  double solarmass=1.98892e30;
  double r2=Math.sqrt(rx*rx+ry*ry);
  double numerator=(6.67e-11)*1e6*solarmass;
  return Math.sqrt(numerator/r2);
}

//Initialize N bodies with random positions and circular velocities
public void startthebodies() {
  double radius = 1e18;        // radius of universe
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
    //Color the masses in green gradients by mass
    int red     = (int) Math.floor(mass*254/(solarmass*10+1e20));
    int blue   = (int) Math.floor(mass*254/(solarmass*10+1e20));
    int green    = 255;
    color c = color(red, green, blue);
    bodies[i]   = new Body(px, py, vx, vy, mass);
  }
  //Put the central mass in
  bodies[0]= new Body(0, 0, 0, 0, 1e6*solarmass);
}

//Use the method in Body to reset the forces, then add all the new forces
/*public void addforces() {
 for (int i = 0; i < bodies.length; i++) {
 bodies[i].resetForce();
 //Notice-2 loops-->N^2 complexity
 for (int j = 0; j < bodies.length; j++) {
 if (i != j) bodies[i].addForce(bodies[j]);
 }
 }
 //Then, loop again and update the bodies using timestep dt
 for (int i = 0; i < bodies.length; i++) {
 bodies[i].update(1e11);
 }
 }*/
//The BH algorithm: calculate the forces
public void addforces() {
  BHTree thetree = new BHTree(q);
  // If the body is still on the screen, add it to the tree
  for (int i = 0; i < bodies.length; i++) {
    if (bodies[i].in(q)) thetree.insert(bodies[i]);
  }
  //Now, use out methods in BHTree to update the forces,
  //traveling recursively through the tree
  for (int i = 0; i < bodies.length; i++) {
    bodies[i].resetForce();
    if (bodies[i].in(q)) {
      thetree.updateForce(bodies[i]);
      //Calculate the new positions on a time step dt (1e11 here)
      bodies[i].update(1e11/3);
    }
  }
}


public static double exp(double lambda) {
  return -Math.log(1 - Math.random()) / lambda;
}

public  Body add(Body body, Body body1)
{
  double d = (body.rx * body.mass + body1.rx * body1.mass) / (body.mass + body1.mass);
  double d1 = (body.ry * body.mass + body1.ry * body1.mass) / (body.mass + body1.mass);
  double d2 = body.mass + body1.mass;
  return new Body(d, d1, 0.0D, 0.0D, d2);
}

