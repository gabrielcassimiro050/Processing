class Organismo {
  PVector pos, vel, acc;
  float life;

  float range, size, maxVel, diet, age, ageExpectancy;

  float[] dna;


  boolean alive = true;

  Organismo(float[] dna, float x, float y) {
    this.dna = dna;
    pos = new PVector(x, y);
    vel = new PVector(random(-1, 1), random(-1, 1));
    range = map(dna[0], 0, 1, minOrganismRange, maxOrganismRange);
    maxVel = map(dna[1], 0, 1, 1, 2);
    size = map(dna[2], 0, 1, minOrganismSize, maxOrganismSize);
    ageExpectancy = map(dna[3], 0, 1, minOrganismAge, maxOrganismAge);
    life = size*10;
    diet = dna[3];
  }

  Organismo(float x, float y) {
    float[] dna = new float[5];
    for (int j = 0; j < dna.length; ++j) {
      dna[j] = random(1);
    }

    this.dna = dna;
    pos = new PVector(x, y);
    vel = new PVector(random(-1, 1), random(-1, 1));
    range = map(dna[0], 0, 1, minOrganismRange, maxOrganismRange);
    maxVel = map(dna[1], 0, 1, 1, 2);
    size = map(dna[2], 0, 1, minOrganismSize, maxOrganismSize);
    ageExpectancy = map(dna[3], 0, 1, minOrganismAge, maxOrganismAge);
    dna[3] = random(.49, 1);
    life = size*10;
    diet = dna[3];
  }

  void update() {
    acc = new PVector(0, 0);
    
    if (diet>=.5) {
      PVector newPosition = new PVector(pos.x, pos.y);
      float menorDist = MAX_FLOAT;
      for (int i = 0; i < plant.size(); ++i) {
        PVector f = plant.get(i).pos;
        
        if (dist(f, pos) < range && dist(f, pos) < menorDist && plant.get(i).size<size) {
          newPosition = f;
          menorDist = dist(f, pos);
        }


        if (dist(f, pos) < size/2.0+plant.get(i).size/2.0 && plant.get(i).size<size) {
          life += plant.get(i).life*diet;
          plant.get(i).plantDied();
        }
      }
      
      acc = PVector.sub(newPosition, pos);
      acc.mult(1/pow(acc.mag()+1, 2));
      

      for (int i = 0; i < organisms.size(); ++i) {
        Organismo o = organisms.get(i);

        if (o!=this && dist(pos, o.pos) < o.size/2.0+size/2.0) {
          //acc.add(PVector.sub(pos, o.pos));
          
        }
      }
      acc.add(new PVector(random(-.01, .01), random(-.01, .01)));
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

    if (diet>=.5) life -= age/ageExpectancy*(vel.mag()+maxVel)*pow(2, size*temperature[floor(pos.x)][floor(pos.y)])/20.0;
    else  life -= age/ageExpectancy*(vel.mag()+maxVel)*pow(2, size*temperature[floor(pos.x)][floor(pos.y)])/25.0;

    life = constrain(life, 0, 100);
    reproduce();
    if (life <= 0) organisms.remove(organisms.indexOf(this));
    age+=.1;
  }

  void reproduce() {
    if (random(1) < .001) {
      float[] dna = new float[5];
      Organismo closeOrganism = this;
      float d = MAX_FLOAT;

      for (int i = 0; i < organisms.size(); ++i) {
        Organismo o = organisms.get(i);
        if (o!=this && dist(o.pos, pos) < range && dist(o.pos, pos) < d) {
          closeOrganism = o;
          d = dist(o.pos, pos);
        }
      }
      if (closeOrganism!=this && closeOrganism.life > closeOrganism.size*1.5 && life > size*1.5) {
        for (int i = 0; i < dna.length; ++i) {

          dna[i] = random(1)<mutationRate ? map(this.dna[i]+random(-mutationFactor/10.0, mutationFactor/10.0), 0, 1, 0, 1) : this.dna[i];
        }

        life -= maxVel*size;

        closeOrganism.life -= closeOrganism.size;
        organisms.add(new Organismo(dna, pos.x, pos.y));
      }
    }
  }

  void show() {
    noStroke();
    fill(lerpColor(#FF0000, #00FF00, dna[3]));
    ellipse(pos.x+offset.x, pos.y+offset.y, size, size);
    //fill(lerpColor(#FF0000, #00FF00, dna[3]), 10);
    //ellipse(pos.x, pos.y, range, range);
  }
}
