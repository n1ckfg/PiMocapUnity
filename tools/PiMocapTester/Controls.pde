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
    Dot1.p.x += offset;
    Dot2.p.x -= offset;
    offset++;
    Dot1.p.x -= offset;
    Dot2.p.x += offset;
  }
  
  if (moveBack) {
    Dot1.p.x += offset;
    Dot2.p.x -= offset;
    offset--;
    if (offset < 0) offset = 0;
    Dot1.p.x -= offset;
    Dot2.p.x += offset;      
  }
  
  if (moveLeft) {
    Dot1.p.x--;
    Dot2.p.x--;
  }
  
  if (moveRight) {
    Dot1.p.x++;
    Dot2.p.x++;
  }
  
  if (moveDown) {
    Dot1.p.y++;
    Dot2.p.y++;
  }
  
  if (moveUp) {
    Dot1.p.y--;
    Dot2.p.y--;
  }
}