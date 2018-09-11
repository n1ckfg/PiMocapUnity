boolean moveUp = false;
boolean moveDown = false;
boolean moveLeft = false;
boolean moveRight = false;
boolean moveForward = false;
boolean moveBack = false;

void keyPressed() {
  switch(key) {
    case('w'):
      moveForward = true;
      break;
    case('s'):
      moveBack = true;
      break;
    case('a'):
      moveLeft = true;
      break;
    case('d'):
      moveRight = true;
      break;
    case('q'):
      moveDown = true;
      break;
    case('e'):
      moveUp = true;
      break;
  }
}

void keyReleased() {
  switch(key) {
    case('w'):
      moveForward = false;
      break;
    case('s'):
      moveBack = false;
      break;
    case('a'):
      moveLeft = false;
      break;
    case('d'):
      moveRight = false;
      break;
    case('q'):
      moveDown = false;
      break;
    case('e'):
      moveUp = false;
      break;
  }
}

void controlsUpdate() {
  if (moveForward) {
    dot1.p.x += offset;
    dot2.p.x -= offset;
    offset++;
    dot1.p.x -= offset;
    dot2.p.x += offset;
  }
  
  if (moveBack) {
    dot1.p.x += offset;
    dot2.p.x -= offset;
    offset--;
    if (offset < 0) offset = 0;
    dot1.p.x -= offset;
    dot2.p.x += offset;      
  }
  
  if (moveLeft) {
    dot1.p.x--;
    dot2.p.x--;
  }
  
  if (moveRight) {
    dot1.p.x++;
    dot2.p.x++;
  }
  
  if (moveDown) {
    dot1.p.y++;
    dot2.p.y++;
  }
  
  if (moveUp) {
    dot1.p.y--;
    dot2.p.y--;
  }
}