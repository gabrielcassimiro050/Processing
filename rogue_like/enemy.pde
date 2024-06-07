class enemy {
  float health;
  PVector pos, vel, acc;
  boolean dead, hit;
  ArrayList<PVector> trail;

  float a;
  bullet bullet;

  enemy(float x, float y) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    trail = new ArrayList<PVector>();
    bullet = new bullet(0, 0, 0, 0, 0, 0, false);
    for (int i = 0; i < 5; ++i) {
      trail.add(new PVector(pos.x, pos.y));
    }
  }
  enemy() {
  }

  void update() {
  }
  void show() {
    rectMode(CENTER);
    for (int i = 0; i < trail.size(); ++i) {
      if (i+1<trail.size()) {
        stroke(#EA2643, 255*i/(float)trail.size());
        strokeWeight(8);
        line(trail.get(i).x, trail.get(i).y, trail.get(i+1).x, trail.get(i+1).y);
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
