class cBall{
  PVector pos;
  float vx, vy;
  
  cBall(float vx, float vy){
    this.vx = vx;
    this.vy = vy;
  }
  
  void update(PVector destiny, int dA){
    float dx = destiny.x-pos.x;
    float dy = destiny.y-pos.y;
    
    
    
    float d = sqrt(dx*dx+dy*dy);
    
    float fx = 0, fy = 0;
    
    if(d>dA){
        fx = dx/d;
        fy = dy/d;
    }
    
    vx = vx*friction + fx;
    vy = vy*friction + fy;
    pos.x+=vx;
    //pos.y+=vy;
    ellipse(pos.x , pos.y, 50, 50);
    line(pos.x-25, pos.y, destiny.x-25, destiny.y);
    line(pos.x+25, pos.y, destiny.x+25, destiny.y);
  }
  void show(){
    ellipse(pos.x , pos.y, 50, 50);
  }

}
