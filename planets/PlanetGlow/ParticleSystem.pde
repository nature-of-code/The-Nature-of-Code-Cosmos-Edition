class ParticleSystem {
  ArrayList<Particle> particles;

  PShape particleShape;

  ParticleSystem(int n) {
    particles = new ArrayList<Particle>();

    for (int i = 0; i < n; i++) {
      Particle p = new Particle();
      particles.add(p);
    }
  }

  void update() {
    for (Particle p : particles) {
      p.update();
      if (p.isDead()) {
        p.rebirth();
      }
    }
  }

  void display() {

    for (Particle p : particles) {
      p.display();
    }
  }
}

