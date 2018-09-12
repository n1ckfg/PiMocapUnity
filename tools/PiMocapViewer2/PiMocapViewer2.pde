int maxDots = 100;
PVector[] dot1 = new PVector[maxDots];
PVector[] dot2 = new PVector[maxDots];
float dotSize = 20;

void setup() {
  size(1280, 480, P3D);
  oscSetup();
}

void draw() {
  background(0);

  noStroke();
  fill(0,0,50);
  rect(0,0,width/2,height);
  fill(50,0,0);
  rect(width/2,0,width,height);
  
  stroke(127);  
  line(width/2, 0, width/2, height);
    
  for (int i=0; i<maxDots; i++) {
    boolean doDot1 = false;
    boolean doDot2 = false;
    if (dot1[i] != null) doDot1 = true;
    if (dot2[i] != null) doDot2 = true;
    
    stroke(63);
    strokeWeight(1);
    if (doDot1) {
      line(0, dot1[i].y, dot1[i].x, dot1[i].y);
      line(dot1[i].x, 0, dot1[i].x, dot1[i].y);
    }
    if (doDot2) {
      line(width, dot2[i].y, dot2[i].x + (width/2), dot2[i].y);
      line(dot2[i].x + (width/2), height, dot2[i].x + (width/2), dot2[i].y);
    }
    
    stroke(255);
    strokeWeight(2);
    if (doDot1 && doDot2) {
      line(dot2[i].x, dot2[i].y, dot1[i].x, dot1[i].y);
      line(dot1[i].x, dot1[i].y, dot2[i].x, dot2[i].y);
    }
    
    strokeWeight(8);
    if (doDot1) {
      stroke(0,127,255);
      point(dot1[i].x, dot1[i].y);
    }
    if (doDot2) {
      stroke(255,63,0);
      point(dot2[i].x + (width/2), dot2[i].y);
    }
    
    stroke(255);
    strokeWeight(2);
    fill(127);
    ellipseMode(CENTER);
    if (doDot1) ellipse(dot1[i].x, dot1[i].y, dotSize, dotSize);
    if (doDot2) ellipse(dot2[i].x + (width/2), dot2[i].y, dotSize, dotSize);
    
    if (doDot1 && doDot2) {
      noStroke();
      fill(140);
      lights();
      pushMatrix();
      float x = (dot1[i].x + dot2[i].x)/2;
      float y = (dot1[i].y + dot2[i].y)/2;
      float z = dist(dot1[i].x, dot1[i].y, dot2[i].x, dot2[i].y);
      translate(x, y, z);
      sphere(dotSize/1.6);
      popMatrix();
    }
  }
}
