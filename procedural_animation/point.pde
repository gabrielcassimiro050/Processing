class Point {
  PVector pos, acc, vel;

  float radius, area, angle;
  Point parent;

  int listIndex;
  boolean anchor;

  Point(float x, float y, float radius, float area) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    this.radius = radius;
    this.area = area;
    anchor = true;
    parent = null;
    
  }

  Point(float x, float y, float radius, float area, Point parent) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    this.radius = radius;
    this.area = area;
    this.parent = parent;
    
  }

  void update() {
    boolean hit = false;
     
    
    float curveFactor = 1;
    //float viewRange = 120;
    //float viewRadius = 250;
    //float newX = cos(radians(angle+random(-viewRange, viewRange)))*random(viewRadius);
    //float newY = sin(radians(angle+random(-viewRange, viewRange)))*random(viewRadius);


    acc = PVector.sub(mouse, pos);

    float dist = acc.mag();
    if (abs(pos.x-width)<area+radius) acc.x -= 1;
    if (abs(pos.x)<area+radius) acc.x += 1;

    if (abs(pos.y-height)<area+radius) acc.y -= 1;
    if (abs(pos.y)<area+radius) acc.y += 1;

    //acc.mult(curveFactor/acc.mag());
    acc.mult(dist);
    acc.normalize();
    acc.mult(curveFactor/acc.mag());

    vel.add(acc);
    vel.mult(.99);
    vel.limit(20);
    if (dist(pos, mouse) < radius) vel = new PVector(0, 0);
    pos.add(vel);

    angle+=random(-1, 1);
  }

  void show() {
    stroke(255);
    strokeWeight(5);

    if (!anchor) fill(#272d35);
    else fill(#F55959);

    ellipse(pos.x, pos.y, radius, radius);

    if (parent!=null) {

      if (dist(pos, parent.pos) > parent.area) {
        float angle = PVector.sub(pos, parent.pos).heading();
        pos = new PVector(parent.pos.x+cos(angle)*parent.area, parent.pos.y+sin(angle)*parent.area);
      }

      parent.show();
    }
  }
}
