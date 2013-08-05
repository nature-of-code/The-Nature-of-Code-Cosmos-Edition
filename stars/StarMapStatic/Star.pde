class Star {
  PVector pos;
  
  Star(float x, float y, float z) {
    pos = new PVector(x,y,z);
  }
  
  void display() {
    point(pos.x,pos.y,pos.z);
  }
  
}
