class Organismo {
  PVector pos, vel, acc;
  float life;

  float range, size, maxVel, diet;

  float[] dna;


  boolean alive = true;

  Organismo(float[] dna, float x, float y) {
    this.dna = dna;
    pos = new PVector(x, y);
    vel = new PVector(random(-1, 1), random(-1, 1));
    range = map(dna[0], 0, 1, minRange, maxRange);
    maxVel = map(dna[1], 0, 1, minVel, maxVel);
    size = map(dna[2], 0, 1, minSize, maxSize);
    diet = dna[3];
    
    life = size*lifeFactor;
  }

  Organismo(float x, float y) {
    float[] dna = new float[nTraits];
    for (int j = 0; j < dna.length; ++j) {
      dna[j] = random(1);
    }

    this.dna = dna;
    pos = new PVector(x, y);
    vel = new PVector(random(-1, 1), random(-1, 1));
    range = map(dna[0], 0, 1, minRange, maxRange);
    this.maxVel = map(dna[1], 0, 1, minVel, maxVel);
    size = map(dna[2], 0, 1, minSize, maxSize);
    dna[3] = standardDiet;
    diet = dna[3];
    
    life = size*lifeFactor;
  }

  void update() {
    acc = new PVector(0, 0);
    if (diet>=.5) {
      for (int i = 0; i < food.size(); ++i) {
        PVector f = food.get(i);
        if (dist(f, pos) < range) {
          acc = PVector.sub(f, pos);
        }
        if (dist(f, pos) < size/2.0+5) {
          food.remove(i);
          life += plantEnergy*diet;
        }
      }
    } else {
      for (int i = 0; i < organisms.size(); ++i) {
        Organismo o = organisms.get(i);
        if (dist(o.pos, pos) < range) {
          acc = PVector.sub(o.pos, pos);
        }

        if (dist(o.pos, pos) < size/2.0+5) {
          organisms.remove(i);
          life += meatEnergy*1/diet;
        }
      }
    }

    for(int i = 0; i < organisms.size(); ++i){
     Organismo o = organisms.get(i);
     if(o.alive && dist(o.pos, pos) < o.size/2.0+size/2.0){
     acc.add(PVector.sub(pos, o.pos));
     acc.normalize();
     }
     }



    if (width-pos.x < size*2) vel.x*=-1;
    if (pos.x < size*2) vel.x*=-1;

    if (height-pos.y < size*2) vel.y*=-1;
    if (pos.y < size*2) vel.y*=-1;

    acc.normalize();

    vel.add(acc);
    vel.mult(.99);
    vel.limit(this.maxVel);
    if (pos.x+vel.x >= border && pos.x+vel.x < width-border) pos.x += vel.x;
    if (pos.y+vel.y >= border && pos.y+vel.y < height-border) pos.y += vel.y;


    life-=this.maxVel*size*energyCost;

    if (life > size*reproductionCost*.5 && random(1)<reproductionRate) reproduce();
    if (life <= 0) organisms.remove(organisms.indexOf(this));
  }

  void reproduce() {
    float[] dna = new float[nTraits];

    for (int i = 0; i < dna.length; ++i) {
      dna[i] = map(this.dna[i]+random(-mutationRate, mutationRate), 0, 1, 0, 1);
    }

    life -= size*reproductionCost;
    organisms.add(new Organismo(dna, pos.x, pos.y));
  }

  void show() {
    noStroke();
    fill(lerpColor(#FF0000, #00FF00, dna[3]));
    ellipse(pos.x+offset.x, pos.y+offset.y, size, size);
  }
}
