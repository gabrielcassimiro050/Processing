class Shape {
  PVector pos, vel, acc;
  ArrayList<PVector> points;
  ArrayList<PVector> pointsVel;
  float size;
  int n;

  float k = .00000001;
  float restLength = 100;

  boolean right, left, up, down;

  Shape(float x, float y, float size, int n) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    points = new ArrayList<PVector>();
    pointsVel = new ArrayList<PVector>();
    this.n = n;
    this.k = .01/(float)n;
    float factor = 360/(float)n;
    float angle = (((n-2)*180)/(float)n)/2.0;
    for (int i = 0; i < n; ++i) {
      points.add(new PVector(pos.x+cos(radians(factor*i+angle))*size, pos.y+sin(radians(factor*i+angle))*size));
      pointsVel.add(new PVector(0, 0));
    }
  }

  void update() {
    this.acc = new PVector(0, 0);
    if (right) this.acc.x++;
    if (left) this.acc.x--;
    if (down) this.acc.y++;
    if (up) this.acc.y--;

    this.vel.add(this.acc);
    this.vel.mult(friction);
    this.pos.add(this.vel);


    for (int i = 0; i < n; ++i) {
      PVector acc = new PVector(0, 0);
      PVector vel = pointsVel.get(i);
      PVector pos = points.get(i);


      vel.add(acc);

      if (pos.x+vel.x+this.vel.x>width || pos.x+vel.x+this.vel.x<0) {
        vel.x*=-impactLoss;
        this.vel.x*=-impactLoss;
      } else {
      }

      if (pos.y+vel.y+this.vel.y>height || pos.y+vel.y+this.vel.y<0) {
        vel.y*=-impactLoss;
        this.vel.y*=-impactLoss;
        //pos.add(vel);
      } else {

        //if (vel.mag()<1) vel = new PVector(0, 0);
        //pos.add(vel);
      }


      for (int j = 0; j < n; ++j) {
        if (j!=i) {

          PVector pos1 = points.get(j);
          PVector force = PVector.sub(pos, pos1);
          float x = force.mag() - restLength;
          force.normalize();
          force.mult(-1 * k * x);
          vel.add(force);
          //vel.mult(.99);
        }
      }
      vel.mult(friction);
      pos.add(vel);
      pos.add(this.vel);
    }
  }

  void show() {
    stroke(255);
    for (int i = 0; i < n; ++i) {
      PVector pos = points.get(i);
      ellipse(pos.x, pos.y, 3, 3);
      for (int j = 0; j < n; ++j) {

        PVector pos1 = points.get(j);
        if(dist(pos.x, pos.y, pos1.x, pos1.y) < restLength/(float)n*15) line(pos.x, pos.y, pos1.x, pos1.y);
      }
    }
  }
}
