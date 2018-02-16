class Button {
  
  PVector p;
  PVector s;
  
  boolean clicked = false;
  boolean hovered = false;
  
  color offColor = color(0);
  color hoveredColor = color(127);
  color clickedColor = color(255);
  color currentColor = offColor;
  
  Button(float px, float py, float sx, float sy) {
    p = new PVector(px, py);
    s = new PVector(sx, sy);
  }
  
  void update() {
    clicked = hovered && mousePressed;
    
    if (hovered && !clicked) {
      currentColor = hoveredColor;
    } else if (hovered && clicked) {
      currentColor = clickedColor;
    } else {
      currentColor = offColor;
    }
  }
  
  void draw() {
    //
  }
  
  void run() {
    update();
    draw();
  }
  
}