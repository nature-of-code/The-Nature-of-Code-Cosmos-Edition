// Start of a simple Kepler Visualization
// based off of the work of Jer Thorp: https://github.com/blprnt/Kepler-Visualization

ArrayList<ExoPlanet> planets = new ArrayList();

// Conversion constants
float ER = 1;           // Earth Radius, in pixels
float AU = 1500;        // Astronomical Unit, in pixels
float YEAR = 2000;     // One year, in frames

float zoom = 0.05;

void setup() {
  size(displayWidth, displayHeight);
  background(0);
  smooth();  
  addMarkerPlanets();
}

void addMarkerPlanets() {
  // Now, add the solar system planets
  ExoPlanet mars = new ExoPlanet();
  mars.period = 686;
  mars.radius = 0.533;
  mars.axis = 1.523;
  mars.temp = 212;
  mars.label = "Mars";
  mars.init();
  planets.add(mars);

  ExoPlanet earth = new ExoPlanet();
  earth.period = 365;
  earth.radius = 1;
  earth.axis = 1;
  earth.temp = 254;
  earth.label = "Earth";
  earth.init();
  planets.add(earth);

  ExoPlanet jupiter = new ExoPlanet();
  jupiter.period = 4331;
  jupiter.radius = 11.209;
  jupiter.axis = 5.2;
  jupiter.temp = 124;
  jupiter.label = "Jupiter";
  jupiter.init();
  planets.add(jupiter);

  ExoPlanet mercury = new ExoPlanet();
  mercury.period = 87.969;
  mercury.radius = 0.3829;
  mercury.axis = 0.387;
  mercury.temp = 434;
  mercury.label = "Mercury";
  mercury.init();
  planets.add(mercury);
}

void draw() {
  background(10);

  translate(width/2, height/2);
  scale(zoom);
  // Draw the sun
  fill(255);
  noStroke();
  ellipse(0, 0, 50, 50);

  // Render the planets
  for (ExoPlanet p : planets) {
    p.update();
    p.render();
  }
}




