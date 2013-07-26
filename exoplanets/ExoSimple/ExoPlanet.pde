// ExoPlanet Class
// based off of the work of Jer Thorp: https://github.com/blprnt/Kepler-Visualization

class ExoPlanet {
  // Data from the imported files
  String KOI;

  float period;
  float radius;
  float temp = 254;
  float axis;

  // Real movement/render properties
  float theta = 0;
  float thetaSpeed = 0;
  float pixelRadius = 0;
  float pixelAxis;

  String label = "";

  boolean feature = false;

  ExoPlanet() {
  }

  // Initialize pixel-based motion data, color, etc. from exoplanet data
  void init() {
    pixelRadius = radius * ER;
    pixelAxis = axis * AU;

    float periodInYears = period/365;
    float periodInFrames = periodInYears * YEAR;
    theta = random(2 * PI);
    thetaSpeed = (2 * PI) / periodInFrames;

    //println(pixelAxis + " " + pixelRadius);
  }


  // Update
  void update() {
    theta += thetaSpeed;
  }

  // Draw
  void render() {
    float x = sin(theta) * pixelAxis;
    float y = cos(theta) * pixelAxis;
    pushMatrix();
    translate(x, y);
    noStroke();
    fill(255,175);
    if (feature) {
      fill(255);
    }
    ellipse(0, 0, pixelRadius+4/zoom, pixelRadius+4/zoom);
    if (feature) {
      stroke(255);
      fill(255);
      strokeWeight(1);
      pushMatrix();
      scale(1/zoom);
      line(0, 0, 45, 0);
      translate(50, 4);
      text(label,0,0);
      popMatrix();
    }
    popMatrix();
  }
}

