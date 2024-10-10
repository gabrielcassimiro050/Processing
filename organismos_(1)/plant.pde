class Plant{
  PVector pos;
  float life, size;

  float age, ageExpectancy;

  float range;

  color c;

  HashMap<String, Float> dna;

  boolean selected;
  
  int generation;
  boolean asexual;
  
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

    generation = 0;
    asexual = true;
  }


  Plant(float x, float y, HashMap<String, Float> dna, int generation, boolean asexual) {
    this.dna = new HashMap<String, Float>();



    pos = new PVector(x, y);

    this.dna.put("size", constrain(dna.get("size") + (random(1) < mutationRate ? random(-plantMutationFactor, plantMutationFactor) : 0), 0, 1));
    size = map(dna.get("size"), 0, 1, minPlantSize, maxPlantSize);

    this.dna.put("range", constrain(dna.get("range") + (random(1)<mutationRate ? random(-plantMutationFactor, plantMutationFactor) : 0), 0, 1));
    range = map(dna.get("range"), 0, 1, minPlantRange, maxPlantRange);



    //c = color(constrain(red(c)+random(-5, 5), 0, 255), constrain(green(c)+random(-5, 5), 0, 255), constrain(blue(c)+random(-5, 5), 0, 255));
    this.dna.put("r", constrain(dna.get("r")+(random(1)<mutationRate ? random(-plantMutationFactor, plantMutationFactor) : 0), 0, 1));
    this.dna.put("g", constrain(dna.get("g")+(random(1)<mutationRate ? random(-plantMutationFactor, plantMutationFactor) : 0), 0, 1));
    this.dna.put("b", constrain(dna.get("b")+(random(1)<mutationRate ? random(-plantMutationFactor, plantMutationFactor) : 0), 0, 1));

    float r = map(this.dna.get("r"), 0, 1, 0, 255);
    float g = map(this.dna.get("g"), 0, 1, 0, 255);
    float b = map(this.dna.get("b"), 0, 1, 0, 255);

    c = color(r, g, b);

    life = map(dna.get("size"), 0, 1, minPlantLife, maxPlantLife);
    ageExpectancy = map(dna.get("size"), 0, 1, minPlantAge, maxPlantAge);

    this.generation = generation+1;    
    this.asexual = asexual;
  }

  float checkDna(HashMap<String, Float> dna) {
    float incompatibility = 0;

    incompatibility += abs(this.dna.get("size")-dna.get("size"));
    incompatibility += abs(this.dna.get("range")-dna.get("range"));
    incompatibility += abs(this.dna.get("r")-dna.get("r"));
    incompatibility += abs(this.dna.get("g")-dna.get("g"));
    incompatibility += abs(this.dna.get("b")-dna.get("b"));

    return incompatibility;
  }

  Plant clone() {
    PVector pos = new PVector(this.pos.x, this.pos.y);
    HashMap<String, Float> dna = new HashMap<String, Float>();
    dna.put("size", this.dna.get("size"));
    dna.put("range", this.dna.get("range"));
    dna.put("r", this.dna.get("r"));
    dna.put("g", this.dna.get("g"));
    dna.put("b", this.dna.get("b"));
    return new Plant(pos.x, pos.y, dna, generation, asexual);
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

    //println(lightFactor);
    float fertility = 1;

    for (int i = 0; i < plant.size(); ++i) {
      Plant f = plant.get(i);
      if (dist(f.pos, pos) < range && dist(f.pos, pos) < f.range) {
        fertility = constrain(fertility-(fertilityFactor*f.size), 0, 1);
        if (random(1) < .1 && checkDna(f.dna) < plantCompatibility && life >= map(dna.get("size"), 0, 1, minPlantLife, maxPlantLife)/2.0 && f.life >= map(f.dna.get("size"), 0, 1, minPlantLife, maxPlantLife)/2.0 && age>ageExpectancy/4.0 && f.age>f.ageExpectancy/4.0) {
          f.life-=f.size*3;
          reproduce(f);
        }
      }
    }



    life -= pow(ambientHarshness, abs(size-temperature[floor(pos.x)][floor(pos.y)])*umidity[floor(pos.x)][floor(pos.y)])*((age/ageExpectancy));
    life += size*lightFactor*fertility;
    

    if (random(1) < .001) reproduce(this);

    life = constrain(life, 0, map(dna.get("size"), 0, 1, minPlantLife, maxPlantLife));
    
    if(selected){
      println(life);
      plantLife = life;
      plantAge = age;
    }
    if (life<=0) plantDied();

    age+=.01;
    
    
  }

  void plantDied() {
    if(selected) plantSelected = null;
    plant.remove(plant.indexOf(this));
  }

  void reproduce(Plant parent) {
    if (parent==this) {
      life-=size/10.0;

      float x = (pos.x+random(-range/2.0, range/2.0)+width)%width;
      float y = (pos.y+random(-range/2.0, range/2.0)+height)%height;
      boolean growth = true;

      loadPixels();

      if (pixels[floor(x)+floor(y)%width] != #11343E) growth = false;

      if (growth) plant.add(new Plant(x, y, dna, generation, true));
    } else {
      HashMap<String, Float> newDna = new HashMap<String, Float>();
      Plant father, mother;
      if (random(1)>.5) {
        father = this;
        mother = parent;
      } else {
        father = parent;
        mother = this;
      }

      newDna.put("size", random(1) > .5 ? mother.dna.get("size") : father.dna.get("size"));
      newDna.put("range", random(1) > .5 ? mother.dna.get("range") : father.dna.get("range"));
      newDna.put("r", random(1) > .5 ? mother.dna.get("r") : father.dna.get("r"));
      newDna.put("g", random(1) > .5 ? mother.dna.get("g") : father.dna.get("g"));
      newDna.put("b", random(1) > .5 ? mother.dna.get("b") : father.dna.get("b"));

      float x = (pos.x+random(-range/2.0, range/2.0)+width)%width;
      float y = (pos.y+random(-range/2.0, range/2.0)+height)%height;
      boolean growth = true;

      loadPixels();

      if (pixels[floor(x)+floor(y)%width] != #11343E) growth = false;

      if (growth) plant.add(new Plant(x, y, newDna, generation, false));
    }
  }

  void show() {
    noStroke();
    fill(c);
    ellipse(pos.x+offset.x, pos.y+offset.y, size, size);

    if (plantRange) {
      stroke(c);
      strokeWeight(1);
      noFill();
      ellipse(pos.x+offset.x, pos.y+offset.y, range, range);
    }
  }
}
