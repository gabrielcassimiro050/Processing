class player {

  PVector pos, vel, acc, recoil;
  boolean right, left, up, down;

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
  }

  void show() {
    noStroke();
    fill(#2761D8);
    rectMode(CENTER);
    rect(pos.x, pos.y, 10, 10);
    for (int i = 0; i < trail.size(); ++i) {
      if (i+1<trail.size()) {
        stroke(#2761D8, 255*i/(float)trail.size());
        strokeWeight(10);
        line(trail.get(i).x, trail.get(i).y, trail.get(i+1).x, trail.get(i+1).y);
      }
    }

    if (charge<maxCharge) {
      fill(#2761D8);
    } else {
      fill(lerpColor(#2761D8, #FFFFFF, map(sin(a), -1, 1, 0, 1)));
      a+=.1;
    }
    ellipse(cos(atan2(mouseY - pos.y, mouseX - pos.x))*(50+charge/2.0)+pos.x, sin(atan2(mouseY - pos.y, mouseX - pos.x))*(50+charge/2.0)+pos.y, 1+charge, 1+charge);
  }
}
