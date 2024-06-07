class sniper extends enemy {

  PVector destiny, nextPos, recoil;
  int cooldown;


  sniper(float x, float y) {
    super(x, y);
    health = 10;
    destiny = new PVector(player.pos.x, player.pos.y);
    nextPos = new PVector(pos.x, pos.y);
    recoil = new PVector(0, 0);
    cooldown = ceil(random(10, 30))*10;
  }

  void update() {
    acc = new PVector(0, 0);
    if (time > cooldown && time%cooldown == 0) {
      destiny = new PVector(player.pos.x, player.pos.y);
      bullet = new bullet(0, pos.x, pos.y, cos(atan2(destiny.y-pos.y, destiny.x-pos.x)), sin(atan2(destiny.y-pos.y, destiny.x - pos.x)), 5, false);
      recoil = new PVector(-cos(atan2(destiny.y-pos.y, destiny.x-pos.x)), -sin(atan2(destiny.y-pos.y, destiny.x - pos.x)));
      nextPos = new PVector(pos.x+random(-100, 100), pos.y+random(-100, 100));
      a = 0;
    } else {
      a-=1/(float)cooldown;
    }

    PVector d = new PVector(nextPos.x-pos.x, nextPos.y-pos.y);
    acc.add(d.mult(1/(d.mag()+1)));
    vel.add(acc);
    vel.add(recoil);
    recoil.mult(.3);
    vel.mult(friction);
    pos.add(vel);


    if (bullet.active) {
      bullet.update();
      bullet.show();
    }

    for (int i = 0; i < trail.size(); ++i) {
      if (i+1< trail.size()) trail.set(i, trail.get(i+1));
      else trail.set(i, new PVector(pos.x, pos.y));
    }

    for (int i = 0; i < bullets.size(); ++i) {
      bullet b = bullets.get(i);
      if (b!=null && dist(pos, b.pos) < 10+b.size) {
        health-=b.size/4.0;
        hit = true;
        bullets.set(b.id, null);
      }
    }
    if (health<=0) dead = true;
  }

  void show() {
    rectMode(CENTER);
    if (vel.mag()>=0) {
      for (int i = 0; i < trail.size(); ++i) {
        if (i+1<trail.size()) {
          stroke(#EA2643, 255*i/(float)trail.size());
          strokeWeight(8);
          line(trail.get(i).x, trail.get(i).y, trail.get(i+1).x, trail.get(i+1).y);
        }
      }
    }

    if (hit) a++;

    if (a>2) {
      a = 0;
      hit = false;
    }
    fill(#EA2643);
    float s = constrain(5+dist(constrain(pos.x, 20, width-20), constrain(pos.y, 20, height-20), pos.x, pos.y)/10.0, 5, 20);
    if (pos.x>=width || pos.x < 0 || pos.y>=height || pos.y < 0) rect(constrain(pos.x, 20, width-20), constrain(pos.y, 20, height-20), s, s);
    noStroke();
    rect(pos.x, pos.y, 10+sin(a)*5, 10+sin(a)*5);
  }
}
