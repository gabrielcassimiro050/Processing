class biomi {
  PVector pos, vel, acc;
  PVector dPos;
  color c;

  float radius, angle, range;
  float curveFactor;
  float size;
  
  ArrayList<PVector> trail;

  biomi(float x, float y, color c, float radius, float range, float angle, float curveFactor, float size) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    this.c = c;
    this.radius = radius;
    this.range = range;
    this.curveFactor = curveFactor;
    this.angle = angle;
    this.size = size;
    dPos = new PVector(x, y);

    trail = new ArrayList<PVector>();

    for (int i = 0; i < 10; ++i) {
      trail.add(pos);
    }
  }


  void update() {
    if (dist(dPos, pos) < 10) {
      dPos = new PVector(random(width), random(height));
    }

    acc = new PVector(dPos.x-pos.x, dPos.y-pos.y);
    acc.mult(.05/acc.mag());
    vel.add(acc);
    vel.limit(maxSpeed);
    angle += vel.heading()-angle;
    if (pos.x+vel.x > width+50) {
      pos.x = -100;
    } else if (pos.x+vel.x < -50) {
      pos.x = width+50;
    } else {
      pos.x += vel.x;
    }
    
    if (pos.y+vel.y > height+50) {
      pos.y = -100;
    } else if (pos.y+vel.y < -50) {
      pos.y = height+50;
    } else {
      pos.y += vel.y;
    }

    /*for (int i = 0; i < trail.size(); ++i) {
      if (i+1< trail.size()) trail.set(i, trail.get(i+1));
      else trail.set(i, new PVector(pos.x, pos.y));
    }*/
  }

  void show() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angle);
    noStroke();
    fill(c);
    ellipse(0, 0, size, size);
    fill(c, 50);
    arc(0, 0, radius, radius, radians(angle-range), radians(angle+range));
    popMatrix();
  }
}
