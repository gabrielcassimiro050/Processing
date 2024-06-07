class follower extends enemy {
  
  float timeAlive;
  
  follower(float x, float y) {
    super(x, y);
    health = 20;
  }

  void update() {
    acc = new PVector(0, 0);
    if (dist(player.pos, pos) < 200+timeAlive*50) {
      PVector d = new PVector(player.pos.x-pos.x, player.pos.y-pos.y);
      acc.add(d.mult(1/d.mag()));
      acc.mult(timeAlive);
      vel.add(acc);
      vel.mult(friction);
      pos.add(vel);
    }
    for (int i = 0; i < trail.size(); ++i) {
      if (i+1< trail.size()) trail.set(i, trail.get(i+1));
      else trail.set(i, new PVector(pos.x, pos.y));
    }
    for (int i = 0; i < bullets.size(); ++i) {
      bullet b = bullets.get(i);
      if (b!=null && dist(pos, b.pos) < 10+b.size) {
        health-=b.size/4.0;
        timeAlive-=b.size/4.0;
        hit = true;
        bullets.set(b.id, null);
      }
    }
    if (health<=0) dead = true;
    timeAlive += .005;
    timeAlive = constrain(timeAlive, 0, 5);
  }
  void show() {
    rectMode(CENTER);
    for (int i = 0; i < trail.size(); ++i) {
      if (i+1<trail.size()) {
        stroke(lerpColor(#EA2643, #EAD426, timeAlive/5.0), 255*i/(float)trail.size());
        strokeWeight(8);
        line(trail.get(i).x, trail.get(i).y, trail.get(i+1).x, trail.get(i+1).y);
      }
    }
    if (hit) a++;

    if (a>2) {
      a = 0;
      hit = false;
    }
    fill(lerpColor(#EA2643, #EAD426, timeAlive/5.0));
    float s = constrain(5+dist(constrain(pos.x, 20, width-20), constrain(pos.y, 20, height-20), pos.x, pos.y)/10.0, 5, 20);
    if (pos.x>=width || pos.x < 0 || pos.y>=height || pos.y < 0) rect(constrain(pos.x, 20, width-20), constrain(pos.y, 20, height-20), s, s);
    noStroke();
    rect(pos.x, pos.y, 10+sin(a)*5, 10+sin(a)*5);
  }
}
