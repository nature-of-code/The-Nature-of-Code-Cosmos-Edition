class Particle {

  PVector position;
  PVector velocity;
  float lifespan = 255;

  PShape part;
  float partSize;

  PVector gravity = new PVector(0, 0.1);


  Particle() {
    position = new PVector();
    partSize = random(10, 60);
    rebirth();
    lifespan = random(127);
  }

  PShape getShape() {
    return part;
  }

  void rebirth() {
    float speed = random(0.5, 2);
    velocity = PVector.random3D();
    velocity.mult(speed);
    lifespan = 127;   
    position = PVector.random3D();
    position.mult(105);
  }

  boolean isDead() {
    if (lifespan < 0) {
      return true;
    } 
    else {
      return false;
    }
  }

  void display() {
    pushMatrix();
    translate(position.x, position.y, position.z);
    rotateX(-rotY);
    rotateY(-rotX);
    if (particleTex) {
      imageMode(CENTER);
      tint(color(255, 255, 255, lifespan));
      image(sprite, 0, 0, partSize, partSize);
    } 
    else {
      stroke(255, lifespan);
      strokeWeight(partSize/4);
      point(0, 0);
    }
    popMatrix();
  }

  void update() {
    position.add(velocity);
    lifespan = lifespan - 10;
  }
}

