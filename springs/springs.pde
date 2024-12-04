Shape s;
float impactLoss = .9;
float friction = .98;

void keyPressed() {
  switch(key) {
  case 'w':
    s.up = true;
    break;
  case 's':
    s.down = true;
    break;
  case 'd':
    s.right = true;
    break;
  case 'a':
    s.left = true;
    break;
  }
}

void keyReleased() {
  switch(key) {
  case 'w':
    s.up = false;
    break;
  case 's':
    s.down = false;
    break;
  case 'd':
    s.right = false;
    break;
  case 'a':
    s.left = false;
    break;
  }
}

void setup() {
  size(750, 750);
  s = new Shape(width/2.0, height/2.0, 50, 15);
 
}

void draw() {
   background(#0E192E, 10);
 // background(#0E192E);
  s.show();
  s.update();
}
