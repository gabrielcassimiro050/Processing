class player {

  PVector pos, vel, acc, recoil;
  boolean right, left, up, down;
  boolean parry;

  ArrayList<PVector> trail;

  float a;

  player(float x, float y) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    recoil = new PVector(0, 0);
    trail = new ArrayList<PVector>();
    for (int i = 0; i < 5; ++i) {
      trail.add(pos);
    }
  }

  void update() {
    acc = new PVector(0, 0);

    if (right) acc.add(new PVector(speed, 0));
    if (left) acc.add(new PVector(-speed, 0));
    if (up) acc.add(new PVector(0, -speed));
    if (down) acc.add(new PVector(0, speed));

    if (!right && !left && !up && !down) friction = .7;
    else friction = frictionAux;
    acc.normalize();
    vel.add(acc);
    vel.limit(maxSpeed);
    vel.mult(friction);
    pos.add(vel);
    pos.add(recoil);
    recoil.mult(friction);
    for (int i = 0; i < trail.size(); ++i) {
      if (i+1< trail.size()) trail.set(i, trail.get(i+1));
      else trail.set(i, new PVector(pos.x, pos.y));
    }

    if (player.parry) println("parry");
    else println("not parry");
    for (enemy e : enemies) {
      if (dist(pos, e.pos) < 10) {
        if (!parry) {
          game = false;
        } else {
          vel.add(new PVector(cos(atan2(e.bullet.pos.y - pos.y, e.bullet.pos.x - pos.x))*recoilPower, sin(atan2(e.bullet.pos.y - pos.y, e.bullet.pos.x - pos.x))*recoilPower));
        }
      }
    }

    for (enemy e : enemies) {
      if (e.bullet.active && dist(e.bullet.pos, pos) < 10) {
        if (!parry) {
          game = false;
        } else {
          vel.add(new PVector(cos(atan2(e.bullet.pos.y - pos.y, e.bullet.pos.x - pos.x))*recoilPower, sin(atan2(e.bullet.pos.y - pos.y, e.bullet.pos.x - pos.x))*recoilPower));
        }
      }
    }
    if (time%10 == 0) parry = false;
  }

  void show() {
    noStroke();
    fill(#2761D8);
    rectMode(CENTER);
    rect(pos.x, pos.y, 10, 10);
    for (int i = 0; i < trail.size(); ++i) {
      if (i+1<trail.size()) {
        stroke(#2761D8, 255*i/(float)trail.size());
        strokeWeight(8);
        line(trail.get(i).x, trail.get(i).y, trail.get(i+1).x, trail.get(i+1).y);
      }
    }

    if (charge<maxCharge) {
      fill(#2761D8);
      //a = 0;
    } else {
      fill(lerpColor(#2761D8, #FFFFFF, map(sin(a), -1, 1, 0, 1)));
      a+=.1;
    }
    
    if (parry) stroke(255);
    ellipse(cos(atan2(mouseY - pos.y, mouseX - pos.x))*(50+charge/2.0)+pos.x, sin(atan2(mouseY - pos.y, mouseX - pos.x))*(50+charge/2.0)+pos.y, 1+charge, 1+charge);
    float s = constrain(5+dist(constrain(pos.x, 20, width-20), constrain(pos.y, 20, height-20), pos.x, pos.y)/10.0, 5, 20);
    if (pos.x>=width || pos.x < 0 || pos.y>=height || pos.y < 0) rect(constrain(pos.x, 20, width-20), constrain(pos.y, 20, height-20), s, s);
  }
}
