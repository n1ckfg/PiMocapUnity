CircleButton Dot1, Dot2;
int buttonSize = 20;
float offset = 20;

void setup() {
  size(1280, 480, P3D);
  oscSetup();
  Dot1 = new CircleButton((width/4) - offset, height/2, buttonSize);
  Dot2 = new CircleButton((3 * (width/4) + offset), height/2, buttonSize);
}

void draw() {
  blendMode(NORMAL);
  background(0);
  if (Dot1.clicked || Dot2.clicked) {
    Dot1.p.add(getMouseDelta());
    Dot2.p.add(getMouseDelta());
  }
  
  controlsUpdate();
  
  stroke(63);
  strokeWeight(1);
  line(0, Dot1.p.y, Dot1.p.x, Dot1.p.y);
  line(Dot1.p.x, 0, Dot1.p.x, Dot1.p.y);
  line(width, Dot2.p.y, Dot2.p.x, Dot2.p.y);
  line(Dot2.p.x, height, Dot2.p.x, Dot2.p.y);

  stroke(255);
  strokeWeight(2);
  line(Dot2.p.x, Dot2.p.y, Dot1.p.x + width/2, Dot1.p.y);
  line(Dot1.p.x, Dot1.p.y, Dot2.p.x - width/2, Dot2.p.y);

  strokeWeight(8);
  stroke(0,127,255);
  point(Dot1.p.x + width/2, Dot1.p.y);
  stroke(255,63,0);
  point(Dot2.p.x - width/2, Dot2.p.y);
  
  stroke(255);
  strokeWeight(2);
  Dot1.run();
  Dot2.run();
  sendOsc();
  
  blendMode(ADD);
  noStroke();
  fill(0,0,50);
  rect(0,0,width/2,height);
  fill(50,0,0);
  rect(width/2,0,width,height);
  
  stroke(127);  
  line(width/2, 0, width/2, height);
  
  blendMode(NORMAL);
  noStroke();
  fill(140);
  lights();
  pushMatrix();
  float x = (Dot1.p.x + Dot2.p.x)/2;
  float y = (Dot1.p.y + Dot2.p.y)/2;
  float z = dist(Dot1.p.x, Dot1.p.y, Dot2.p.x - (width/2), Dot2.p.y);
  translate(x, y, z);
  sphere(buttonSize/1.6);
  popMatrix();
}

PVector getMouseDelta() {
    return new PVector(mouseX, mouseY).sub(new PVector(pmouseX, pmouseY));
}