class Food {
  PVector pos;
  float life, size;
  float age, ageExpectancy;

  float range;


  Food(float x, float y) {
    pos = new PVector(x, y);
    size = random(1, 5);
    life = map(size, 1, 5, 50, 100);
    range = random(20, 100);
    ageExpectancy = map(size, 1, 5, 30, 70);
  }

  void update() {

    life += size*lightFactor;




    for (int i = 0; i < food.size(); ++i) {
      Food f = food.get(i);
      if (dist(f.pos, pos) < range && dist(f.pos, pos) < f.range) {
        if (random(1) < .1 && life >= map(size, 1, 5, 50, 100)*2 && age > ageExpectancy/2.0 && f.life >= map(f.size, 1, 5, 50, 100)*2 && f.age > f.ageExpectancy/2.0 ) {
          f.life-=f.size*10;
          reproduce();
        }
      }
    }

    if (life<=0) food.remove(food.indexOf(this));
    if (age>=ageExpectancy) food.remove(food.indexOf(this));
    ++age;
  }

  void reproduce() {
    life-=size*10;
    food.add(new Food((pos.x+random(-10, 10)+width)%width, (pos.y+random(-10, 10)+height)%height));
  }

  void show() {

    fill(255);
    ellipse(pos.x, pos.y, size, size);
  }
}
