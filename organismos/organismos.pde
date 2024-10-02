ArrayList<Plant> plant;
ArrayList<Organismo> organisms;

float minPlantSize = 3, maxPlantSize = 10;
float minPlantRange = 20, maxPlantRange = 100;
float minPlantLife = 50, maxPlantLife = 200;
float minPlantAge = 50, maxPlantAge = 150;

float minOrganismSize = 3, maxOrganismSize = 10;
float minOrganismRange = 20, maxOrganismRange = 100;



ArrayList<Integer> populationData;
ArrayList<Integer> plantData;
boolean menuIsOpen, tempIsOpen, umidIsOpen;

float tempSeed = random(100000);
float umidSeed = random(100000);
float[][] temperature, umidity;
float scl = .005;

int nPlant = 500;
int time;
int maxOrganisms = 1000;

color lightSpectrum = color(0, 200, 0);
float lightIntolerance = 1.5;

float mutationRate = .0001;
float mutationFactor = 1;

float dist(PVector p1, PVector p2) {
  return dist(p1.x, p1.y, p2.x, p2.y);
}

void setplant() {
  plant = new ArrayList<Plant>();
  for (int i = 0; i < nPlant; ++i) {
    plant.add(new Plant(random(20, width-20), random(20, height-20)));
  }
}

void growplant() {
  int randomPlant = round(random(10, nPlant));
  for (int i = 0; i < randomPlant; ++i) plant.add(new Plant(random(20, width-20), random(20, height-20)));
}

void showplant() {
  for (int i = 0; i < plant.size(); ++i) plant.get(i).show();
}

void updateplant() {
  for (int i = 0; i < plant.size(); ++i) plant.get(i).update();
}

void setOrganisms(int nOrganisms) {
  organisms = new ArrayList<Organismo>();
  for (int i = 0; i < nOrganisms; ++i) {
    organisms.add(new Organismo(random(20, width-20), random(20, height-20)));
  }
}

void showOrganisms() {
  for (int i = 0; i < organisms.size(); ++i) {
    Organismo o = organisms.get(i);
    if (o.alive) o.show();
  }
}

void updateOrganisms() {
  for (int i = 0; i < organisms.size(); ++i) {
    Organismo o = organisms.get(i);
    if (o.alive) o.update();
    else organisms.remove(i);
  }
}

void showGraph() {
  float l = width/(float)populationData.size();
  noStroke();

  rectMode(CENTER);
  for (int i = 0; i < populationData.size(); ++i) {

    fill(#00FF00);
    rect(i*l, 0, l, height*plantData.get(i)/(populationData.size()*l));
    fill(255);
    rect(i*l, height, l, height*populationData.get(i)/(populationData.size()*l));
  }
}

void showTemp() {
  for (int x = 0; x < width; ++x) {
    for (int y = 0; y < height; ++y) {
      float groupingValue = 16;
      color pix = 255;

      if (temperature[x][y]<.5) {
        pix = lerpColor(255, #3CBFE5, map(temperature[x][y], 0, .5, 0, 1));
      } else {
        pix = lerpColor(#FFD608, #FF2D08, map(temperature[x][y], .5, 1, 0, 1));
      }


      float r = red(pix), g = green(pix), b = blue(pix);
      r = round(groupingValue*r/255)*(255/groupingValue);
      g = round(groupingValue*g/255)*(255/groupingValue);
      b = round(groupingValue*b/255)*(255/groupingValue);


      fill(color(r, g, b));
      rect(x, y, 1, 1);
    }
  }
}

void showUmid() {
  for (int x = 0; x < width; ++x) {
    for (int y = 0; y < height; ++y) {
      fill(lerpColor(#0000FF, #86FFFE, umidity[x][y]));
      rect(x, y, 1, 1);
    }
  }
}

void setAmbient() {
  temperature = new float[width][height];
  umidity = new float[width][height];
  for (int x = 0; x < width; ++x) {
    for (int y = 0; y < height; ++y) {
      temperature[x][y] = noise(x*scl, y*scl, tempSeed);
      umidity[x][y] = noise(x*scl, y*scl, umidSeed);
    }
  }
}

void keyReleased() {
  switch(key) {
  case 'g':
    if (menuIsOpen) menuIsOpen = false;
    else menuIsOpen = true;
    break;
  case 't':
    if (tempIsOpen) tempIsOpen = false;
    else tempIsOpen = true;

    break;
  case 'u':
    if (umidIsOpen) umidIsOpen = false;
    else umidIsOpen = true;

    break;
  }
}


void mouseReleased() {
  setup();
}

void setup() {
  size(1200, 500);
  populationData = new ArrayList<Integer>();
  plantData = new ArrayList<Integer>();
  setplant();
  setOrganisms(50);
  tempSeed = random(10000);
  umidSeed = random(10000);
  setAmbient();
  time = 0;
}

void draw() {
  background(#11343E);
  
  if (tempIsOpen) showTemp();
  if (umidIsOpen) showUmid();
  
  showOrganisms();
  updateOrganisms();
  showplant();
  updateplant();
  
  //if (time%100==0) growplant();
  surface.setTitle("População: "+organisms.size());

  if (time%1==0) {
    populationData.add(organisms.size());
    plantData.add(plant.size());
  }
  
  if (organisms.size()+plant.size()<=1) setup();
  
  if(time%100 == 0){
    tempSeed += random(-.1, .1);
    umidSeed += random(-.1, .1);
    setAmbient();
  }

  if (menuIsOpen) showGraph();
  ++time;
}
