class Organismo {
  PVector pos, vel, acc;
  float life = 100;

  float range, size, maxVel, diet;

  float[] dna;


  boolean alive = true;

  Organismo(float[] dna, float x, float y) {
    this.dna = dna;
    pos = new PVector(x, y);
    vel = new PVector(random(-1, 1), random(-1, 1));
    range = map(dna[0], 0, 1, 0, 50);
    maxVel = map(dna[1], 0, 1, 1, 5);
    size = map(dna[2], 0, 1, 5, 10);
    dna[3] = .5;
    diet = dna[3];
  }

  Organismo(float x, float y) {
    float[] dna = new float[4];
    for (int j = 0; j < dna.length; ++j) {
      dna[j] = random(1);
    }

    this.dna = dna;
    pos = new PVector(x, y);
    vel = new PVector(random(-1, 1), random(-1, 1));
    range = map(dna[0], 0, 1, 0, 150);
    maxVel = map(dna[1], 0, 1, 1, 5);
    size = map(dna[2], 0, 1, 5, 10);
    dna[3] = .5;
    diet = dna[3];
  }

  void update() {
    acc = new PVector(0, 0);
    if (diet>=.5) {
      for (int i = 0; i < food.size(); ++i) {
        PVector f = food.get(i);
        if (dist(f, pos) < range) {
          acc = PVector.sub(f, pos);
        }

        if (dist(f, pos) < size+5) {
          food.remove(i);
          life += 10;
        }
      }
    } else {
      for (int i = 0; i < organisms.size(); ++i) {
        Organismo o = organisms.get(i);
        if (dist(o.pos, pos) < range) {
          acc = PVector.sub(o.pos, pos);
        }

        if (dist(o.pos, pos) < size+5) {
          organisms.remove(i);
          life += 30;
        }
      }
    }

    /*for(int i = 0; i < organisms.size(); ++i){
     Organismo o = organisms.get(i);
     if(o.alive && dist(o.pos, pos) < o.size/2.0+size/2.0){
     acc.add(PVector.sub(pos, o.pos));
     acc.normalize();
     }
     }*/



    if (width-pos.x < size*2) vel.x*=-1;
    if (pos.x < size*2) vel.x*=-1;

    if (height-pos.y < size*2) vel.y*=-1;
    if (pos.y < size*2) vel.y*=-1;

    acc.normalize();

    vel.add(acc);
    vel.mult(.99);
    vel.limit(maxVel);
    if (pos.x+vel.x >= 20 && pos.x+vel.x < width-20) pos.x += vel.x;
    if (pos.y+vel.y >= 20 && pos.y+vel.y < height-20) pos.y += vel.y;


    life-=maxVel*size/10.0;

    if (life > 50 && random(1)<.009) reproduce();
    if (life <= 0) organisms.remove(organisms.indexOf(this));
  }

  void reproduce() {
    float[] dna = new float[4];

    for (int i = 0; i < dna.length; ++i) {
      dna[i] = map(this.dna[i]+random(-.1, .1), 0, 1, 0, 1);
    }

    life -= size;
    organisms.add(new Organismo(dna, pos.x, pos.y));
  }

  void show() {
    noStroke();
    fill(lerpColor(#00FF00, #FF0000, dna[1]));
    ellipse(pos.x, pos.y, size, size);
  }
}
