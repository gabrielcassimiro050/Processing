PVector offset;

ArrayList<PVector> food;
ArrayList<Organismo> organisms;
int nFood = 1350;
int time, frame = 1;

float border = -1000;

float mutationRate  = .1;
float reproductionRate = .01, reproductionEnergy = 50;
float reproductionCost = 1.1;
float standardDiet = .5;
int nTraits = 4;

float plantEnergy  = 70;
float meatEnergy = 150;

float minRange = 20, maxRange = 70;
float minVel = 1, maxVel = 15;
float minSize = 5, maxSize = 15;

float lifeFactor = 3;
float energyCost = .1;

float dist(PVector p1, PVector p2) {
  return dist(p1.x, p1.y, p2.x, p2.y);
}

void setSimulation() {
  setFood();
  setOrganisms(50);
  offset = new PVector(0, 0);
  time = 0;
}

void setFood() {
  food = new ArrayList<PVector>();
  for (int i = 0; i < nFood; ++i) {
    food.add(new PVector(random(border, width-border), random(border, height-border)));
  }
}

void growFood() {
  int randomFood = round(random(10, nFood));
  for (int i = 0; i < randomFood; ++i) food.add(new PVector(random(border, width-border), random(border, height-border)));
}

void showFood() {
  fill(255);
  for (PVector f : food) {
    ellipse(f.x+offset.x, f.y+offset.y, 5, 5);
  }
}

void setOrganisms(int nOrganisms) {
  organisms = new ArrayList<Organismo>();
  for (int i = 0; i < nOrganisms; ++i) {
    organisms.add(new Organismo(random(border, width-border), random(border, height-border)));
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

void keyPressed() {
  switch(key) {
  case 'a':
    frame = constrain(frame-1, 1, 15);
    break;
  case 'd':
    frame = constrain(frame+1, 1, 15);
    break;
  }
}


void mouseReleased() {
  if (mouseButton==RIGHT) setup();
}

void setup() {
  size(1200, 500);
  setSimulation();
}

void draw() {
  background(#11343E);
  showOrganisms();
  showFood();
  if (time%frame==0) {

    updateOrganisms();
    if (time%100==0) growFood();
    surface.setTitle("População: "+organisms.size());
  }

  if (mousePressed) {
    PVector center = new PVector(width/2.0, height/2.0);
    PVector mouse = new PVector(mouseX, mouseY);
    offset.add(PVector.sub(center, mouse).normalize().mult(10));
  }

  ++time;
}
