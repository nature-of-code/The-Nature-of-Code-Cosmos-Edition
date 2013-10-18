class Planet {

  PShape shape;
  PImage texture;

  PVector pos;
  PVector rot;

  float radius;

  ArrayList<Planet> orbits;

  boolean light = false;
  boolean ring = false;
  
  PVector spinAngles;
  PVector orbitAngles;
  PVector spinSpeed;
  PVector orbitSpeed;

  Planet(PImage t, float r) {
    orbits = new ArrayList<Planet>();
    pos = new PVector();
    texture = t;
    radius = r;
    noStroke();
    sphereDetail(40);
    shape = createShape(SPHERE, r);
    shape.setTexture(texture);

    spinAngles = new PVector();
    orbitAngles = new PVector();
    spinSpeed = new PVector();
    orbitSpeed = new PVector();
  }

  void addOrbit(Planet p, float x, float y, float z) {
    p.setPosition(x, y, z);
    orbits.add(p);
  }

  void setPosition(float x, float y, float z) {
    pos.x = x;
    pos.y = y;
    pos.z = z;
  }

  void setOrbit(float x, float y, float z) {
    orbitSpeed.x = x;
    orbitSpeed.y = y;
    orbitSpeed.z = z;
  }

  void setSpin(float x, float y, float z) {
    spinSpeed.x = x;
    spinSpeed.y = y;
    spinSpeed.z = z;
  }

  void orbit() {
    orbitAngles.add(orbitSpeed);
    rotateX(orbitAngles.x);
    rotateY(orbitAngles.y);
    rotateZ(orbitAngles.z);
  }

  void spin() {
    spinAngles.add(spinSpeed);
  }

  void display() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    pushMatrix();
    rotateX(spinAngles.x);
    rotateY(spinAngles.y);
    rotateZ(spinAngles.z);
    shape(shape);
    if (ring) {
      rotateZ(spinAngles.z);
      rotateY(spinAngles.y);
      rotateX(spinAngles.x);
      rotateY(-PI/2);
      imageMode(CENTER);
      image(ringImg, 0, 0, radius*5, radius*5);
    }

    popMatrix();

    if (light) {
      pointLight(255, 255, 255, 0, 0, 0);
    }


    for (Planet p : orbits) {
      pushMatrix();
      p.orbit();
      p.display();
      popMatrix();
    }
    popMatrix();
  }
}

