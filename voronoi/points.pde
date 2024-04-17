class cPoint{
  PVector pos;
  PVector vel;
  color c;
  int type;
  
  void show(){
    fill(c);
    //fill(lerpColor(c, 0, .5));
    noStroke();
    ellipse(pos.x, pos.y, width/(float)rez, height/(float)rez);    
  }
  void update(){
    pos.add(round(random(-2, 2)), round(random(-2, 2)));
  }
}
