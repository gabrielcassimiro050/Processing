class Segment {
  PVector pos;
  ArrayList<Point> body;

  Segment(float x, float y, ArrayList<Point> body) {
    this.body = body;
    pos = new PVector(x, y);
  }

  void update() {
    pos = new PVector(body.get(0).pos.x, body.get(0).pos.y);
    body.get(0).update();

    boolean hit = false;

    for (bullet b : bullets) {
      for (int i = 0; i < body.size(); ++i) {
        Point p = body.get(i);
        if (b!=null && b.active && dist(p.pos, b.pos) < p.radius+10) {
          segments.add(setPoints(body.size()/2, pos.x, pos.y, 20, 20));
          b.active = false;
          hit = true;
        }
      }
    }

    if (hit) {
      segments.set(segments.indexOf(this), setPoints(body.size()/2, pos.x, pos.y, 20, 20));
      body.get(0).vel.mult(-1);
      segments.get(segments.indexOf(this)+1).body.get(0).vel.mult(-1);
    }
  }

  void show() {
    for (Point p : body) p.show();
  }
}
