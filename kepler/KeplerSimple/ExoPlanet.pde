// ExoPlanet Class
// based off of the work of Jer Thorp: https://github.com/blprnt/Kepler-Visualization

class ExoPlanet {
  // Data from the imported files
  String KOI;

  float period;
  float radius;
  float temp;
  float axis;
  int vFlag = 1;
  
  // Real movement/render properties
  float theta = 0;
  float thetaSpeed = 0;
  float pixelRadius = 0;
  float pixelAxis;

  String label = "";

  // Constructor function
  ExoPlanet() {};
  
  // Load exoplanet data from a comma-delimited string (see key at top of class)
  ExoPlanet fromCSV2012(String[] sa) {
    KOI = sa[0];
    period = float(sa[1]);
    radius = float(sa[2]);
    axis = float(sa[3]);
    temp = float(sa[4]);
    return(this);
  }

  // Load exoplanet data from a comma-delimited string (see key at top of class)
  ExoPlanet fromCSV(String[] sa) {
    KOI = sa[0];
    period = float(sa[6]);
    radius = float(sa[14]);
    axis = float(sa[15]);
    temp = float(sa[16]);
    vFlag = int(sa[18]);
    return(this);
  }

  // Initialize pixel-based motion data, color, etc. from exoplanet data
  ExoPlanet init() {
    pixelRadius = radius * ER;
    pixelAxis = axis * AU;

    float periodInYears = period/365;
    float periodInFrames = periodInYears * YEAR;
    theta = random(2 * PI);
    thetaSpeed = (2 * PI) / periodInFrames;

    return(this);
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
    fill(255);
    stroke(255);
    strokeWeight(0.25/zoom);
    line(0,0,45/zoom,0);
    textSize(12/zoom);
    text(label,50/zoom,4/zoom);
    ellipse(0, 0, pixelRadius*50, pixelRadius*50);
    popMatrix();
  }
}

