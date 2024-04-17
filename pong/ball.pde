class ball {
  PVector pos;

  void show() {
    ellipse(pos.x, pos.y, s, s);
  }

  void update() {

    if (pos.x>=width) {
      vx = random(1);
      vy = random(1);
      sp = 5;
      ball.pos = new PVector(width/2, height/2);

      p1Score++;
    }
    if (pos.x<=0) {
      vx = random(.5, 1)*(random(1) >.5 ? 1 : -1);
      vy = random(.5, 1)*(random(1) >.5 ? 1 : -1);
      sp = 5;
      ball.pos = new PVector(width/2, height/2);
      p2Score++;
    }
    if (pos.y>=height || pos.y<=0) {
      vx = map(vx+random(-.5,.5), vx-.5, vx+.5,  vx-.5, vx+.5);;
      vy*=-1;
    }
    if (abs(player1.pos.x-pos.x)<=s && abs(player1.pos.y-pos.y)<=s*5) {
      vy = map(vy+random(-.5,.5), vy-.5, vy+.5, vy-.5, vy+.5);
      vx*=-1;
    }
    if (abs(player2.pos.x-pos.x)<=s && abs(player2.pos.y-pos.y)<=s*5) {
      vx*=-1;
    }
    vx = constrain(vx, -1, 1);
    vy = constrain(vy, -1, 1);
    pos.x+=vx*sp;
    pos.y+=vy*sp;
  }
}
