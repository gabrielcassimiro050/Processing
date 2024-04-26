class particle{
  PVector p;
  PVector v;
  int type;
  color c;
  
  particle(float x, float y, int t, color c){
    p  = new PVector(x, y);
    v = new PVector(0, 0);
    type = t;
    this.c = c;
  }


  void show(){ 
    noStroke();
    fill(c);
    ellipse(p.x, p.y, 5, 5);
  }
}
