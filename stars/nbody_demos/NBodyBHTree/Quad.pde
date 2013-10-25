// NOC Cosmos
// NBody Simulation
// https://github.com/shiffman/The-Nature-of-Code-Cosmos-Edition

// This example is more efficient using the Barnes-Hut QuadTree algorithm
// http://en.wikipedia.org/wiki/Barnes%E2%80%93Hut_simulation
// https://www.khanacademy.org/cs/quadtree-hut-tree/1179074380

// Adapted from http://physics.princeton.edu/~fpretori/Nbody/

class Quad {

  double xmid, ymid, length;
  
  // Create a square quadrant with a given length and midpoints (xmid,ymid)
  Quad(double xmid, double ymid, double length) {
    this.xmid=xmid;
    this.ymid=ymid; 
    this.length=length;
  }

  // How long is this quadrant?
  double length() {
    return length;
  }

  // Check if the current quadrant contains a point
  boolean contains(double xmid, double ymid) {
    if (xmid<=this.xmid+this.length/2.0 && xmid>=this.xmid-this.length/2.0 && ymid<=this.ymid+this.length/2.0 && ymid>=this.ymid-this.length/2.0) {
      return true;
    }
    else {
      return false;
    }
  }
  
  // Create subdivisions of the current quadrant

  // Subdivision: Northwest quadrant
  Quad NW() {
    Quad newquad = new Quad(this.xmid-this.length/4.0, this.ymid+this.length/4.0, this.length/2.0);
    return newquad;
  }

  // Subdivision: Northeast quadrant
  Quad NE() {
    Quad newquad = new Quad(this.xmid+this.length/4.0, this.ymid+this.length/4.0, this.length/2.0);
    return newquad;
  }

  // Subdivision: Southwest quadrant
  Quad SW() {
    Quad newquad = new Quad(this.xmid-this.length/4.0, this.ymid-this.length/4.0, this.length/2.0);
    return newquad;
  }

  // Subdivision: Southeast quadrant
  Quad SE() {
    Quad newquad = new Quad(this.xmid+this.length/4.0, this.ymid-this.length/4.0, this.length/2.0);
    return newquad;
  }
}

