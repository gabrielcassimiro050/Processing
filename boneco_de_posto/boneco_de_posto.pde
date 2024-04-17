cBall ball[];
int nBalls = 3;

float friction = .7;
float a = -1;

void setup() {
  size(500, 500);
  ball = new cBall[nBalls];
  for (int i = 0; i < nBalls; ++i) {
    ball[i] = new cBall((i+1)*5, (i+1)*5);
    ball[i].pos = new PVector(width/2, (i+1)*150);
  }
}

void draw() {
  background(255);
  //ball.pos = new PVector(map(width*cos(a), -width, width, 0, width), height-400);
  //ellipse(ball.pos.x , ball.pos.y, 50, 50);
  for (int i = nBalls-1; i>=0; --i) {
    if (i!=0) {
      ball[i].update(ball[i-1].pos, 100/(i+1));
    }else{  
      ball[i].update(new PVector(mouseX, mouseY), 10);
    }
  }
}
