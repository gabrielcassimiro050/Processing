class bullet {
  int id;
  PVector pos, vel, acc;
  float size;

  ArrayList<PVector> trail;
  boolean isPlayer, active;

  bullet(int id, float x, float y, float ax, float ay, float size, boolean isPlayer) {
    this.id = id;
    this.size = size;
    this.isPlayer = isPlayer;
    active = true;
    pos = new PVector(x, y);
    acc = new PVector(ax, ay);
    vel = new PVector(0, 0);
    trail = new ArrayList<PVector>();
    for (int i = 0; i < 5; ++i) {
      trail.add(new PVector(pos.x, pos.y));
    }
  }

  void update() {
    vel.add(acc);
    pos.add(vel);
    if (isPlayer) {
      if (pos.x < -50 || pos.x > width+50) bullets.set(id, null);
      if (pos.y < -50 || pos.y > height+50) bullets.set(id, null);
    } else {
      if (pos.x < -50 || pos.x > width+50) active = false;
      if (pos.y < -50 || pos.y > height+50) active = false;
    }
    for (int i = 0; i < trail.size(); ++i) {
      if (i+1< trail.size()) trail.set(i, trail.get(i+1));
      else trail.set(i, new PVector(pos.x, pos.y));
    }
  }

  void show() {

    if(isPlayer) fill(#2761D8);
    else fill(#EA2643);
    for (int i = 0; i < trail.size(); ++i) {
      if (i+1<trail.size()) {
        stroke((isPlayer ? #2761D8 : #EA2643), 255*i/(float)trail.size());
        strokeWeight(size/2.0);
        line(trail.get(i).x, trail.get(i).y, trail.get(i+1).x, trail.get(i+1).y);
      }
    }

    noStroke();
    ellipse(pos.x, pos.y, size, size);
  }
}
