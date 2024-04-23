class bola {
  PVector p;
  PVector v;
  float a;


  bola(float x, float y) {
    p = new PVector(x, y);
    v = new PVector(0, 0);
    a = .1;
  }

  void update() {
    
    if (p.y+v.y+15>=height){
      v.mult(-.9);
    } else {
      p.add(v);
      v.y += a;
    }
  }

  void show() {
    imageMode(CENTER);
    image(bola_png, p.x, p.y, 30, 30);
  }
}
