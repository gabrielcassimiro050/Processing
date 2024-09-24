class Food{
  PVector pos;
  float life;
  
  Food(float x, float y){
    pos = new PVector(x, y);
    life = (int)random(50, 150);
  }
  
  void update(){
    life-=.5;
    if(life<=0) food.remove(food.indexOf(this));
  }
  
  void show(){
    float size = map(life, 0, 100, 1, 10);
    fill(255);
    ellipse(pos.x, pos.y, size, size);
  }
}
