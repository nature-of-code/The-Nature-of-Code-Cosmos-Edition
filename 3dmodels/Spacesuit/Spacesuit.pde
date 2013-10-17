import saito.objloader.*;

OBJModel spacesuit;

boolean bTexture = true;
boolean bStroke = false;


float rotX, rotY;

void setup() {
  size(800, 600, P3D);
  spacesuit = new OBJModel(this, "acesjustforroomshow.obj", "relative", QUADS);
  spacesuit.enableDebug();
  spacesuit.scale(200);
  spacesuit.translateToCenter();
  noStroke();
}



void draw() {
  background(0);
  lights();
  pushMatrix();
  translate(width/2, height/2, 0);
  rotateX(rotY);
  rotateY(rotX);
  if (bStroke) {
    stroke(255);
  } else {
    noStroke();
  }
  spacesuit.draw();
  popMatrix();
}


void keyPressed()
{
  if (key == 't') {
    if (!bTexture) {
      spacesuit.enableTexture();
      bTexture = true;
    } 
    else {
      spacesuit.disableTexture();
      bTexture = false;
    }
  }

  if (key == 's') {
    bStroke = !bStroke;
  }
}

void mouseDragged() {
  rotX += (mouseX - pmouseX) * 0.01;
  rotY -= (mouseY - pmouseY) * 0.01;
}

