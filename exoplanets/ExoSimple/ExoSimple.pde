// Start of a simple ExoPlanets Visualization
// based off of the work of Jer Thorp: https://github.com/blprnt/Kepler-Visualization

// This example makes use of the Exoplanet Orbit Database
// and the Exoplanet Data Explorer at exoplanets.org.

ArrayList<ExoPlanet> planets = new ArrayList();

// Conversion constants
float ER = 1;           // Earth Radius, in pixels
float AU = 1500;        // Astronomical Unit, in pixels
float YEAR = 20000;     // One year, in frames

float zoom = 0.3;

void setup() {
  size(displayWidth, displayHeight, P2D);
  background(0);
  loadPlanets("exoplanets-kepler.csv");
  //loadPlanets("exoplanets-orbit.csv");
  addMarkerPlanets();
}

void loadPlanets(String file) {
  Table table = loadTable(file, "header");
  for (TableRow row : table.rows()) {
    ExoPlanet ep = new ExoPlanet();
    ep.period = row.getFloat("PER");
    String rad = row.getString("R");
    // Accounting for no radius
    if (rad.length() == 0) {
      ep.radius = 1;
    } 
    else {
      ep.radius = row.getFloat("R");
    }
    ep.axis = row.getFloat("A");   
    //ep.feature = true;
    ep.label = row.getString("NAME");
    ep.init();

    //if (ep.label.contains("Kepler")) {
    planets.add(ep);
    //}
  }
  // Don't seem to have temperature with this dataset
  // ep.temp =
}



void draw() {
  //println(frameCount);

  if (zoomin) zoom += 0.01;
  if (zoomout) zoom -= 0.01;
  zoom = constrain(zoom, 0.01, 0.99);

  background(10);

  pushMatrix();
  translate(width/2, height/2);
  scale(zoom);

  strokeWeight(1.5/zoom);
  noFill();

  // Draw a 2 AU ring
  stroke(255, 100);
  ellipse(0, 0, AU * 2, AU * 2);

  // Draw a 1 AU ring
  stroke(255, 100);
  ellipse(0, 0, AU, AU);

  // Draw a 10 AU ring
  ellipse(0, 0, AU * 10, AU * 10);

  // Draw the sun
  //fill(255);
  //noStroke();
  //ellipse(0, 0, 50, 50);

  // Render the planets
  for (ExoPlanet p : planets) {
    p.update();
    p.render();
  }

  popMatrix();

  text("Total exoplanets: " + planets.size(), 10, 60);
  text("Frame rate: " + int(frameRate), 10, 80);
  text("Scale: " + nf(zoom, 2, 2), 10, 100);
}

void addMarkerPlanets() {
  // Now, add the solar system planets
  ExoPlanet mars = new ExoPlanet();
  mars.period = 686;
  mars.radius = 0.533;
  mars.axis = 1.523;
  mars.temp = 212;
  mars.label = "Mars";
  mars.feature = true;
  mars.init();
  planets.add(mars);

  ExoPlanet earth = new ExoPlanet();
  earth.period = 365;
  earth.radius = 1;
  earth.axis = 1;
  earth.temp = 254;
  earth.label = "Earth";
  earth.feature = true;
  earth.init();
  planets.add(earth);

  ExoPlanet jupiter = new ExoPlanet();
  jupiter.period = 4331;
  jupiter.radius = 11.209;
  jupiter.axis = 5.2;
  jupiter.temp = 124;
  jupiter.label = "Jupiter";
  jupiter.feature = true;
  jupiter.init();
  planets.add(jupiter);

  ExoPlanet mercury = new ExoPlanet();
  mercury.period = 87.969;
  mercury.radius = 0.3829;
  mercury.axis = 0.387;
  mercury.temp = 434;
  mercury.label = "Mercury";
  mercury.feature = true;
  mercury.init();
  planets.add(mercury);
}

boolean zoomout = false;
boolean zoomin = false;
void keyPressed() {
  if (key == 'a') {
    zoomin = true;
  } 
  else if (key == 'z') {
    zoomout = true;
  }
}

void keyReleased() {
  if (key == 'a') {
    zoomin = false;
  } 
  else if (key == 'z') {
    zoomout = false;
  }
}

