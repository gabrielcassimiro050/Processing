class Plant {
  PVector pos;
  float life, size;

  float age, ageExpectancy;

  float range;

  color c;

  HashMap<String, Float> dna;

  Plant(float x, float y) {
    dna = new HashMap<String, Float>();

    pos = new PVector(x, y);

    dna.put("size", random(1));
    size = map(dna.get("size"), 0, 1, minPlantSize, maxPlantSize);


    dna.put("range", random(1));
    range = map(dna.get("range"), 0, 1, minPlantRange, maxPlantRange);


    float r = random(1);
    float g = random(1);
    float b = random(1);

    dna.put("r", r);
    dna.put("g", g);
    dna.put("b", b);

    r = map(r, 0, 1, 0, 255);
    g = map(g, 0, 1, 0, 255);
    b = map(b, 0, 1, 0, 255);

    c = color(r, g, b);

    life = map(dna.get("size"), 0, 1, minPlantLife, maxPlantLife);
    ageExpectancy = map(dna.get("size"), 0, 1, minPlantAge, maxPlantAge);
  }


  Plant(float x, float y, HashMap<String, Float> dna) {
    this.dna = new HashMap<String, Float>();



    pos = new PVector(x, y);

    this.dna.put("size", constrain(dna.get("size") + (random(1) < mutationRate ? random(-.01, .01) : 0), 0, 1));
    size = map(dna.get("size"), 0, 1, minPlantSize, maxPlantSize);

    this.dna.put("range", constrain(dna.get("range") + (random(1)<mutationRate ? random(-.01, .01) : 0), 0, 1));
    range = map(dna.get("range"), 0, 1, minPlantRange, maxPlantRange);



    //c = color(constrain(red(c)+random(-5, 5), 0, 255), constrain(green(c)+random(-5, 5), 0, 255), constrain(blue(c)+random(-5, 5), 0, 255));
    this.dna.put("r", constrain(dna.get("r")+(random(1)<mutationRate ? random(-.001, .001) : 0), 0, 1));
    this.dna.put("g", constrain(dna.get("g")+(random(1)<mutationRate ? random(-.001, .001) : 0), 0, 1));
    this.dna.put("b", constrain(dna.get("b")+(random(1)<mutationRate ? random(-.001, .001) : 0), 0, 1));

    float r = map(this.dna.get("r"), 0, 1, 0, 255);
    float g = map(this.dna.get("g"), 0, 1, 0, 255);
    float b = map(this.dna.get("b"), 0, 1, 0, 255);

    c = color(r, g, b);

    life = map(dna.get("size"), 0, 1, minPlantLife, maxPlantLife);
    ageExpectancy = map(dna.get("size"), 0, 1, minPlantAge, maxPlantAge);
  }

  void update() {

    float rL = red(lightSpectrum);
    float gL = green(lightSpectrum);
    float bL = blue(lightSpectrum);

    float r = red(c);
    float g = green(c);
    float b = blue(c);

    float lightFactor = sqrt(pow((r-rL), 2)+pow((g-gL), 2)+pow((b-bL), 2))/(255*sqrt(3));
    lightFactor = map(lightFactor, 0, 1, 0, 255);
    lightFactor = (-4*pow(lightFactor, 2)/255)+4*lightFactor;
    lightFactor /= 255*lightIntolerance;

    println(lightFactor);

    life -= (pow(2, size/map(temperature[floor(pos.x)][floor(pos.y)], 0, 1, 0, 2)*map(umidity[floor(pos.x)][floor(pos.y)], 0, 1, 0, 2)))*age/ageExpectancy;
    life += size*lightFactor;

    for (int i = 0; i < plant.size(); ++i) {
      Plant f = plant.get(i);
      if (dist(f.pos, pos) < range && dist(f.pos, pos) < f.range) {
        if (random(1) < .01 && life >= map(size, 1, 5, 50, 100)*1.5 && f.life >= map(f.size, 1, 5, 50, 100)*1.5 && age>ageExpectancy/2.0 && f.age>f.ageExpectancy/2.0) {
          f.life-=f.size*3;
          reproduce(f);
        }
      }
    }

    if (random(1) < .0001) reproduce(this);

    life = constrain(life, 0, map(dna.get("size"), 0, 1, 100, 500));

    if (life<=0) plant.remove(plant.indexOf(this));
    age+=.1;
  }

  void reproduce(Plant parent) {
    if (parent==this) {
      life-=size/10.0;

      float x = (pos.x+random(-range, range)+width)%width;
      float y = (pos.y+random(-range, range)+height)%height;
      boolean growth = true;

      loadPixels();

      if (pixels[floor(x)+floor(y)%width] != #11343E) growth = false;

      if (growth) plant.add(new Plant(x, y, dna));
    }else{
      HashMap<String, Float> newDna = new HashMap<String, Float>();
      Plant father, mother;
      if(random(1)>.5){
        father = this;
        mother = parent;
      }else{
        father = parent;
        mother = this;
      }
      
      newDna.put("size", random(1) > .5 ? mother.dna.get("size") : father.dna.get("size")); 
      newDna.put("range", random(1) > .5 ? mother.dna.get("range") : father.dna.get("range")); 
      newDna.put("r", random(1) > .5 ? mother.dna.get("r") : father.dna.get("r")); 
      newDna.put("g", random(1) > .5 ? mother.dna.get("g") : father.dna.get("g")); 
      newDna.put("b", random(1) > .5 ? mother.dna.get("b") : father.dna.get("b")); 
      
      float x = (pos.x+random(-range, range)+width)%width;
      float y = (pos.y+random(-range, range)+height)%height;
      boolean growth = true;

      loadPixels();

      if (pixels[floor(x)+floor(y)%width] != #11343E) growth = false;

      if (growth) plant.add(new Plant(x, y, newDna));
    }
  }

  void show() {
    noStroke();
    fill(c);
    ellipse(pos.x+offset.x, pos.y+offset.y, size, size);
  }
}
