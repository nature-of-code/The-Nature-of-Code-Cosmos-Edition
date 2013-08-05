class Star {
  PVector pos;
  float partSize = 20;

  Star(float x, float y, float z) {
    pos = new PVector(x, y, z);
  }

  void display() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    rotateY(-frameCount * 0.01);
    //shape(part,0,0);
    image(star,0,0,20,20);
    
    /*beginShape(QUAD);
    noStroke();
    tint(255);//, opacity * 255);
    texture(star);
    normal(0, 0, 1);
    vertex(- partSize/2, - partSize/2, 0, 0);
    vertex( partSize/2, - partSize/2, star.width, 0);
    vertex( partSize/2, partSize/2, star.width, star.height);
    vertex(- partSize/2, partSize/2, 0, star.height);        
    //vertex(pos.x - partSize/2, pos.y - partSize/2, pos.z,0, 0);
    //vertex(pos.x + partSize/2, pos.y - partSize/2, pos.z,star.width, 0);
    //vertex(pos.x + partSize/2, pos.y + partSize/2, pos.z,star.width, star.height);
    //vertex(pos.x - partSize/2, pos.y + partSize/2, pos.z,0, star.height);                      
    endShape();  */

    popMatrix();
    //point(pos.x,pos.y,pos.z);
  }
}

