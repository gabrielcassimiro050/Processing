class charger extends enemy {

  PVector destiny;
  int cooldown;

  charger(float x, float y) {
    super(x, y);
    health = 10;
    destiny = new PVector(player.pos.x, player.pos.y);
    cooldown = ceil(random(5, 10))*10;
  }

  void update() {
    acc = new PVector(0, 0);
    if (time%cooldown == 0) {
      destiny = new PVector(player.pos.x+random(-20, 20), player.pos.y+random(-20, 20));
    }
    if (time > cooldown && dist(pos, destiny)>10) {
      PVector d = new PVector(destiny.x-pos.x, destiny.y-pos.y);
      acc.x += d.x;
      acc.y += d.y;
      vel.add(acc.mult(.1));
      vel.mult(.5);
      pos.add(vel);
    } else {
      vel = new PVector(0, 0);
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
    if(health<=0) dead = true;
  }
}
