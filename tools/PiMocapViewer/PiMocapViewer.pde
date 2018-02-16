CircleButton dot1, dot2;
int buttonSize = 20;
float offset = 20;

void setup() {
  size(1280, 480, P3D);
  oscSetup();
  dot1 = new CircleButton((width/4) - offset, height/2, buttonSize);
  dot2 = new CircleButton((3 * (width/4) + offset), height/2, buttonSize);
}

void draw() {
  blendMode(NORMAL);
  background(0);
  /*
  if (dot1.clicked || dot2.clicked) {
    dot1.p.add(getMouseDelta());
    dot2.p.add(getMouseDelta());
  }
  
  controlsUpdate();
  */
  
  stroke(63);
  strokeWeight(1);
  line(0, dot1.p.y, dot1.p.x, dot1.p.y);
  line(dot1.p.x, 0, dot1.p.x, dot1.p.y);
  line(width, dot2.p.y, dot2.p.x, dot2.p.y);
  line(dot2.p.x, height, dot2.p.x, dot2.p.y);

  stroke(255);
  strokeWeight(2);
  line(dot2.p.x, dot2.p.y, dot1.p.x + width/2, dot1.p.y);
  line(dot1.p.x, dot1.p.y, dot2.p.x - width/2, dot2.p.y);

  strokeWeight(8);
  stroke(0,127,255);
  point(dot1.p.x + width/2, dot1.p.y);
  stroke(255,63,0);
  point(dot2.p.x - width/2, dot2.p.y);
  
  stroke(255);
  strokeWeight(2);
  dot1.run();
  dot2.run();
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
  float x = (dot1.p.x + dot2.p.x)/2;
  float y = (dot1.p.y + dot2.p.y)/2;
  float z = dist(dot1.p.x, dot1.p.y, dot2.p.x - (width/2), dot2.p.y);
  translate(x, y, z);
  sphere(buttonSize/1.6);
  popMatrix();
}

PVector getMouseDelta() {
    return new PVector(mouseX, mouseY).sub(new PVector(pmouseX, pmouseY));
}