class Stroke {
  
  ArrayList<PVector> points;
  
  Stroke() {
    points = new ArrayList<PVector>();
  }
  
  void update() {
  }
  
  void draw() {
    noFill();
    stroke(255);
    if (points.size() > 1) {
      beginShape();
      for (int i=0; i<points.size(); i++) {
        PVector p = points.get(i);
        vertex(p.x, p.y, p.z);
      }
      endShape();
    }
  }
  
  void run() {
    update();
    draw();
  }

}
