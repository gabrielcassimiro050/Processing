tab player1;
tab player2;
ball ball;
float vx = random(.5, 1)*(random(1) >.5 ? 1 : -1), vy = random(.5, 1)*(random(1) >.5 ? 1 : -1);
float sp = 2;
float psp = 5;
float s = 10;

int p1Score = 0;
int p2Score = 0;
boolean up1, down1;
boolean up2, down2;

void keyPressed() {
  switch(key) {
  case 'w':
    up1 = true;
    break;
  case 's':
    down1 = true;
    break;
  }
  switch(keyCode) {
  case UP:
    up2 = true;
    break;
  case DOWN:
    down2 = true;
    break;
  }
}

void keyReleased() {
  switch(key) {
  case 'w':
    up1 = false;
    break;
  case 's':
    down1 = false;
    break;
  }
  switch(keyCode) {
  case UP:
    up2 = false;
    break;
  case DOWN:
    down2 = false;
    break;
  }
}
void setup() {
  size(500, 500);
  player1 = new tab();
  player2 = new tab();
  player1.pos = new PVector(50, height/2);
  player2.pos = new PVector(width-50, height/2);
  ball = new ball();
  ball.pos = new PVector(width/2, height/2);
}

void draw() {
  background(255);
  player1.show();
  player2.show();
  ball.show();
  ball.update();
  fill(0);
  text(p1Score, width/2-50, 50);
  text(p2Score, width/2+50, 50);
  if (up1) player1.pos.y-=psp;
  if (down1) player1.pos.y+=psp;
  if (up2) player2.pos.y-=psp;
  if (down2) player2.pos.y+=psp;
  
  sp+=.01;
}
