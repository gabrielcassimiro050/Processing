class planet {
  PVector pos;
  PVector posSCL;
  color c;
  float s;
  float sSCL;
  float a;
  float speed;
  int idMoon;
  boolean glows;
  boolean orbit;

  void show() {
    sSCL = s*scl;
    if (orbit) {
      noFill();
      stroke(255);
      float d = dist(posSCL.x, posSCL.y, 0, 0);
      ellipse(0+offsetX/scl, 0+offsetY/scl, d*2, d*2);
    }
    noStroke();
    fill(c);
    
    if (glows) {
      //filter(BLUR, 5);
    }
    ellipse(posSCL.x+offsetX/scl, posSCL.y+offsetY/scl, sSCL, sSCL);
    filter(NORMAL);
  }

  void update(planet obj) {
    posSCL.x = pos.x*scl;
    posSCL.y = pos.y*scl;
    pushMatrix();
    translate(obj.posSCL.x, obj.posSCL.y);
    //println(obj.pos.x+" "+obj.pos.y);
    float d = dist(posSCL.x, posSCL.y, 0, 0);

    posSCL.x = cos(a)*d;
    posSCL.y = sin(a)*d;

    show();
    popMatrix();
    a += speed;
  }
}
