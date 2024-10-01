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
    range = map(dna[0], 0, 1, 50, 250);
    maxVel = map(dna[1], 0, 1, 1, 5);
    size = map(dna[2], 0, 1, 5, 10);

    life = size*10;
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
    range = map(dna[0], 0, 1, 50, 250);
    maxVel = map(dna[1], 0, 1, 1, 5);
    size = map(dna[2], 0, 1, 2, 15);
    dna[3] = random(.49, 1);
    life = size*10;
    diet = dna[3];
  }

  void update() {
    acc = new PVector(0, 0);
    acc.add(new PVector(random(-1, 1), random(-1, 1)));
    if (diet>=.5) {
      for (int i = 0; i < food.size(); ++i) {
        PVector f = food.get(i).pos;
        if (dist(f, pos) < range && food.get(i).size<size) {
          acc = PVector.sub(f, pos);
        }


        if (dist(f, pos) < size/2.0+food.get(i).size/2.0 && food.get(i).size<size) {
          life += food.get(i).life*diet;
          food.remove(i);
        }
      }

      for (int i = 0; i < organisms.size(); ++i) {
        Organismo o = organisms.get(i);
        if (o!=this && dist(pos, o.pos) < range && o.diet <= .5) {
          acc.add(PVector.sub(pos, o.pos));
        }

        if (o!=this && dist(pos, o.pos) < o.size/2.0+size/2.0) {
          acc.add(PVector.sub(pos, o.pos));
          acc.normalize();
          //else acc.add(PVector.sub(pos, o.pos));
        }
      }
    } else {
      for (int i = 0; i < organisms.size(); ++i) {
        Organismo o = organisms.get(i);
        if (o!=this && dist(o.pos, pos) < range && o.diet >= .5) {
          acc = PVector.sub(o.pos, pos);
        }

        if (o!=this && dist(o.pos, pos) < size+5 && o.diet >= .5 && o.size<size) {
          organisms.remove(i);
          life += 70*(1/diet);
        }

        if (o!=this && dist(pos, o.pos) < o.size/2.0+size/2.0) {
          acc.add(PVector.sub(pos, o.pos));
          acc.normalize();
          //else acc.add(PVector.sub(pos, o.pos));
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

    /*
    if (pos.x+vel.x >= 20 && pos.x+vel.x < width-20) pos.x += vel.x;
     if (pos.y+vel.y >= 20 && pos.y+vel.y < height-20) pos.y += vel.y;
     */

    pos.x = (pos.x+vel.x+width)%width;
    pos.y = (pos.y+vel.y+height)%height;

    if (diet>=.5) life -= maxVel*size/20.0;
    else  life -= maxVel*size/25.0;

    life = constrain(life, 0, 100);
    reproduce();
    if (life <= 0) organisms.remove(organisms.indexOf(this));
  }

  void reproduce() {
    //if (organisms.size()+1<maxOrganisms) {
      float[] dna = new float[4];
      Organismo closeOrganism = this;
      float d = MAX_FLOAT;

      for (int i = 0; i < organisms.size(); ++i) {
        Organismo o = organisms.get(i);
        if (o!=this && dist(o.pos, pos) < range && dist(o.pos, pos) < d) {
          closeOrganism = o;
          d = dist(o.pos, pos);
        }
      }
      if (closeOrganism!=this && closeOrganism.life > 50 && life > 50 && random(1) < .03) {
        for (int i = 0; i < dna.length; ++i) {

          dna[i] = random(1)<mutationRate ? map(this.dna[i]+random(-mutationFactor/10.0, mutationFactor/10.0), 0, 1, 0, 1) : this.dna[i];
        }

        life -= maxVel*size;

        closeOrganism.life -= closeOrganism.size;
        organisms.add(new Organismo(dna, pos.x, pos.y));
      //}
    }
  }

  void show() {
    noStroke();
    fill(lerpColor(#FF0000, #00FF00, dna[3]));
    ellipse(pos.x, pos.y, size, size);
    //fill(lerpColor(#FF0000, #00FF00, dna[3]), 10);
    //ellipse(pos.x, pos.y, range, range);
  }
}
