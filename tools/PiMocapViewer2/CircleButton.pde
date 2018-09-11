class CircleButton extends Button {
  
  CircleButton(float x, float y, float s) {
    super(x, y, s, s);
  }
  
  void update() {
    hovered = hitDetectCircle(mouseX, mouseY, 1, p.x, p.y, s.x);
    super.update();
  }
  
  void draw() {
    fill(currentColor);
    ellipseMode(CENTER);
    ellipse(p.x, p.y, s.x, s.y);
  }
  
  // 2D CIRCLE hit detect: xy, diameter of object 1; xy, diameter of object 2; assumes center.
  boolean hitDetectCircle(float x1, float y1, float d1, float x2, float y2, float d2) {
    d1 /= 2;
    d2 /= 2;
    if (dist(x1, y1, x2, y2) < d1 + d2) {
      return true;
    } else {
      return false;
    }
  }
    
}